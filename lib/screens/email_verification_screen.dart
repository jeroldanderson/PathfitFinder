import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth_service.dart';
import '../theme.dart';
import '../widgets/shared.dart';
import 'auth_screen.dart';
import 'marketplace_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _checking = false;
  bool _resending = false;

  Future<void> _checkVerified() async {
    setState(() => _checking = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      final refreshed = FirebaseAuth.instance.currentUser;

      if (!mounted) return;
      if (refreshed != null && refreshed.emailVerified) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => const MarketplaceScreen()),
          (_) => false,
        );
      } else {
        showNotice(
          context,
          'Email not verified yet. Open the verification link sent to your UST Gmail inbox.',
        );
      }
    } catch (_) {
      if (mounted) {
        showNotice(context, 'Could not check verification status. Try again.');
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _resendEmail() async {
    setState(() => _resending = true);
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      if (mounted) {
        showNotice(context, 'Verification link sent to ${widget.email}.');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        showNotice(
          context,
          e.code == 'too-many-requests'
              ? 'Please wait a minute before requesting another link.'
              : 'Could not resend verification email. Try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => AuthScreen(authService: FirebaseAuthService()),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Brand(),
              const SizedBox(height: 36),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.mark_email_unread_outlined,
                  size: 28,
                  color: ink,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Verify your UST email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We sent a verification link to:\n${widget.email}',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: ink,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Click the link in your UST Gmail inbox (check Spam if needed), then tap the button below to continue into PathFitFinder.',
                style: TextStyle(fontSize: 13, height: 1.5, color: muted),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                "I've verified my email",
                loading: _checking,
                onPressed: _checkVerified,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _resending ? null : _resendEmail,
                  child: Text(
                    _resending ? 'Sending link…' : 'Resend verification link',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: _signOut,
                  child: const Text(
                    'Use a different UST email',
                    style: TextStyle(fontSize: 12, color: muted),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}