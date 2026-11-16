import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/auth_controller.dart';
import '../models/auth_models.dart';
import '../services/media_service.dart';
import '../services/auth_service.dart';
import '../theme.dart';
import '../widgets/shared.dart';
import 'marketplace_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    this.login = false,
    this.authService = const UnconnectedAuthService(),
    this.mediaService,
  });
  final bool login;
  final AuthService authService;
  final MediaService? mediaService;
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late final _controller = AuthController(service: widget.authService);
  late final _media = widget.mediaService ?? MediaService();
  XFile? _document;
  String? _documentError;
  bool _picking = false;
  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pick(bool camera) async {
    setState(() {
      _picking = true;
      _documentError = null;
    });
    try {
      final image = await _media.pick(camera: camera);
      if (mounted && image != null) setState(() => _document = image);
    } catch (_) {
      if (mounted) {
        setState(
          () => _documentError =
              'Unable to open ${camera ? 'camera' : 'photos'}. Check permissions or try uploading an image.',
        );
      }
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _submit() async {
    final valid = _form.currentState!.validate();
    if (!widget.login && _document == null) {
      setState(() => _documentError = 'Add your UST ID or RegForm image.');
      if (valid) return;
    }
    if (!valid) return;
    FocusScope.of(context).unfocus();
    await _controller.submit(
      registration: !widget.login,
      email: _email.text.trim(),
      password: _password.text,
      username: _username.text,
      verificationPath: _document?.path ?? '',
    );
    _password.clear();
  }

  void _switch() {
    _password.clear();
    if (widget.login) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const AuthScreen(login: true)),
      );
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _controller,
    builder: (context, _) => Scaffold(
      body: SafeArea(
        child: PageBody(
          child: AutofillGroup(
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Brand(),
                  const SizedBox(height: 28),
                  const Text(
                    'PASS IT ON. KEEP IT THOMASIAN.',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: muted,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.login
                        ? 'Welcome back.\nYour circle awaits.'
                        : 'Your next fit.\nOur campus circle.',
                    style: const TextStyle(
                      fontSize: 32,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.login
                        ? 'Find your next fit and pick up where you left off.'
                        : 'Buy, sell, and give your PATHFIT uniform\na second semester.',
                    style: const TextStyle(color: muted, fontSize: 14),
                  ),
                  const SizedBox(height: 26),
                  if (!widget.login)
                    Field(
                      'Username',
                      child: TextFormField(
                        key: const Key('username'),
                        controller: _username,
                        validator: AuthValidators.username,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          hintText: 'Choose your username',
                        ),
                      ),
                    ),
                  Field(
                    'UST Email',
                    child: TextFormField(
                      key: const Key('email'),
                      controller: _email,
                      validator: AuthValidators.email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        hintText: 'yourname@ust.edu.ph',
                      ),
                    ),
                  ),
                  Field(
                    'Password',
                    child: TextFormField(
                      key: const Key('password'),
                      controller: _password,
                      obscureText: !_controller.passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: (v) => AuthValidators.password(
                        v,
                        registration: !widget.login,
                      ),
                      autofillHints: [
                        widget.login
                            ? AutofillHints.password
                            : AutofillHints.newPassword,
                      ],
                      onFieldSubmitted: (_) =>
                          _controller.loading ? null : _submit(),
                      decoration: InputDecoration(
                        hintText: widget.login
                            ? 'Enter your password'
                            : 'Create a password',
                        helperText: widget.login
                            ? null
                            : 'At least 8 characters',
                        suffixIcon: IconButton(
                          tooltip: _controller.passwordVisible
                              ? 'Hide password'
                              : 'Show password',
                          onPressed: _controller.togglePassword,
                          icon: _controller.passwordVisible
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 20,
                                  color: muted,
                                )
                              : const DesignIcon('5eefc.svg', size: 20),
                        ),
                      ),
                    ),
                  ),
                  if (!widget.login) ...[
                    const SizedBox(height: 6),
                    const Text(
                      'Verify your Thomasian connection',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add a clear photo of your UST ID or RegForm.',
                      style: TextStyle(fontSize: 12, color: muted),
                    ),
                    const SizedBox(height: 16),
                    DashedPanel(
                      child: Column(
                        children: [
                          if (_document != null) ...[
                            Row(
                              children: [
                                Photo(_document!.path, width: 54, height: 54),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _document!.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Remove document',
                                  onPressed: () =>
                                      setState(() => _document = null),
                                  icon: const Icon(Icons.close, size: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                          Row(
                            children: [
                              Expanded(
                                child: _uploadButton(
                                  'Take photo',
                                  '181d3.svg',
                                  () => _pick(true),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _uploadButton(
                                  'Upload image',
                                  '961b6.svg',
                                  () => _pick(false),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (_documentError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _documentError!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DesignIcon('d447d.svg', size: 14),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Private verification only. Never shown on your profile.',
                            style: TextStyle(fontSize: 10, color: muted),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                  ],
                  if (_controller.error != null) ...[
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        _controller.error!,
                        key: const Key('auth-error'),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                  PrimaryButton(
                    widget.login ? 'Log in' : 'Create my account',
                    trailing: widget.login
                        ? null
                        : const DesignIcon('65392.svg', size: 20),
                    loading: _controller.loading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: _controller.loading ? null : _switch,
                      child: Text(
                        widget.login
                            ? 'Don’t have an account? Sign up'
                            : 'Already in the circle? Log in',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      key: const Key('explore-preview'),
                      onPressed: _controller.loading
                          ? null
                          : () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const MarketplaceScreen(),
                              ),
                            ),
                      child: const Text(
                        'Explore marketplace preview',
                        style: TextStyle(fontSize: 12, color: muted),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
  Widget _uploadButton(String label, String icon, VoidCallback onTap) =>
      Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: _picking ? null : onTap,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DesignIcon(icon, size: 23),
                const SizedBox(height: 10),
                Text(
                  _picking ? 'Opening…' : label,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
}
