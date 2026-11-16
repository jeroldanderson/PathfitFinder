import '../models/auth_models.dart';

abstract class AuthService {
  Future<void> register(RegistrationRequest request);
  Future<void> login({required String email, required String password});
}

/// Replace this adapter with Firebase Auth, Firestore, and Storage later.
/// Credentials are never persisted or logged.
class UnconnectedAuthService implements AuthService {
  const UnconnectedAuthService();
  @override
  Future<void> register(RegistrationRequest request) async {
    throw const AuthUnavailable();
  }

  @override
  Future<void> login({required String email, required String password}) async {
    throw const AuthUnavailable();
  }
}
