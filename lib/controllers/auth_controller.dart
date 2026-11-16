import 'package:flutter/foundation.dart';

import '../models/auth_models.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  AuthController({this._service = const UnconnectedAuthService()});
  final AuthService _service;
  bool loading = false;
  bool passwordVisible = false;
  String? error;
  bool _disposed = false;
  void togglePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  Future<void> submit({
    required bool registration,
    required String email,
    required String password,
    String username = '',
    String verificationPath = '',
  }) async {
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      if (registration) {
        await _service.register(
          RegistrationRequest(
            username: username,
            email: email,
            password: password,
            verificationPath: verificationPath,
          ),
        );
      } else {
        await _service.login(email: email, password: password);
      }
    } on AuthUnavailable catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Unable to connect. Please try again later.';
    } finally {
      loading = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
