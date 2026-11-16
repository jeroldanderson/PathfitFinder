class RegistrationRequest {
  const RegistrationRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.verificationPath,
  });
  final String username, email, password, verificationPath;
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

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your UST email.';
    if (!RegExp(
      r'^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\.)*ust\.edu\.ph$',
      caseSensitive: false,
    ).hasMatch(value.trim())) {
      return 'Use a valid UST email (name@ust.edu.ph).';
    }
    return null;
  }

  static String? password(String? value, {bool registration = true}) {
    if (value == null || value.isEmpty) return 'Enter your password.';
    if (registration && value.length < 8) return 'Use at least 8 characters.';
    return null;
  }
}
