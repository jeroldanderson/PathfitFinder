import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../dataconnect_generated/generated.dart';
import '../models/auth_models.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService({
    fb_auth.FirebaseAuth? auth,
    ExampleConnector? connector,
  })  : _auth = auth ?? fb_auth.FirebaseAuth.instance,
        _connector = connector ?? ExampleConnector.instance;

  final fb_auth.FirebaseAuth _auth;
  final ExampleConnector _connector;

  @override
  Future<void> register(RegistrationRequest request) async {
    final normalizedEmail = request.email.trim().toLowerCase();

    final emailError = AuthValidators.email(normalizedEmail);
    if (emailError != null) {
      throw AuthFailure(emailError);
    }

    fb_auth.UserCredential? credential;
    try {
      // 1. Create Firebase Auth account
      credential = await _auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: request.password,
      );
      await credential.user!.updateDisplayName(request.username.trim());

      // 2. Compress & encode UST ID / RegForm as Base64 data URI
      final documentDataUri = await _encodeVerificationDocument(
        localPath: request.verificationPath,
      );

      // 3. Create User record in Data Connect (status defaults to PENDING)
      final userResult = await _connector
          .createUser(
            email: normalizedEmail,
            fullName: request.username.trim(),
          )
          .execute();

      final createdUserId = userResult.data.user_insert.id;

      // 4. Create VerificationSubmission record linked to the new User
      await _connector
          .createVerificationSubmission(
            userId: createdUserId,
            documentType: VerificationDocType.UST_ID,
            documentUrl: documentDataUri,
          )
          .execute();
    } on fb_auth.FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseAuthError(e));
    } catch (e) {
      if (credential?.user != null) {
        await credential!.user!.delete();
      }
      if (e is AuthFailure) rethrow;
      throw const AuthFailure(
        'Registration failed while saving your profile. Please try again.',
      );
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    try {
      await _auth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      final res = await _connector
          .getUserByEmail(email: normalizedEmail)
          .execute();

      if (res.data.users.isEmpty) {
        await _auth.signOut();
        throw const AuthFailure(
          'Account profile not found. Please register first.',
        );
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseAuthError(e));
    }
  }

  Future<String> _encodeVerificationDocument({
    required String localPath,
  }) async {
    if (localPath.isEmpty) {
      throw const AuthFailure('Please attach your UST ID or RegForm photo.');
    }

    final file = File(localPath);
    if (!await file.exists()) {
      throw const AuthFailure('Selected verification image could not be read.');
    }

    final compressedBytes = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 65,
      minWidth: 800,
      minHeight: 800,
    );

    final bytes = compressedBytes ?? await file.readAsBytes();
    return 'data:image/jpeg;base64,${base64Encode(bytes)}';
  }

  String _mapFirebaseAuthError(fb_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This UST email is already registered. Try logging in.';
      case 'invalid-email':
        return 'Enter a valid @ust.edu.ph email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 8 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect UST email or password.';
      case 'user-disabled':
        return 'This account has been disabled. Contact the team.';
      default:
        return e.message ?? 'Authentication error. Please try again.';
    }
  }
}