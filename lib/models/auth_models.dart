class RegistrationRequest {
  const RegistrationRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.verificationPath,
  });
  final String username, email, password, verificationPath;
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);
  final String message;
}

class AuthUnavailable implements Exception {
  const AuthUnavailable();
  String get message =>
      'Backend authentication is not connected yet. '
      'No account has been created and you have not been signed in.';
}

class AuthValidators {
  static String? username(String? value) {
    if (value == null || value.isEmpty) return 'Enter a username.';
    if (!RegExp(r'^[A-Za-z0-9_.]{3,20}$').hasMatch(value)) {
      return 'Use 3–20 letters, numbers, underscores, or periods.';
    }
    return null;
  }

  static final RegExp _ustEmailPattern = RegExp(
    r'^[a-z0-9]+(\.[a-z0-9]+){1,3}@ust\.edu\.ph$',
  );

  static String? email(String? value) {
    final trimmed = (value ?? '').trim().toLowerCase();
    if (trimmed.isEmpty) {
      return 'Enter your UST email address.';
    }
    if (!trimmed.endsWith('@ust.edu.ph')) {
      return 'Must be an official @ust.edu.ph email address.';
    }
    if (!_ustEmailPattern.hasMatch(trimmed)) {
      return 'Use your full UST email (e.g. firstname.lastname.college@ust.edu.ph).';
    }
    return null;
  }

  static String? password(String? value, {bool registration = true}) {
    if (value == null || value.isEmpty) return 'Enter your password.';
    if (registration && value.length < 8) return 'Use at least 8 characters.';
    return null;
  }
}