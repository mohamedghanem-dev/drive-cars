import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onAuthenticated;
  final VoidCallback onBack;

  const LoginScreen({
    super.key,
    required this.onAuthenticated,
    required this.onBack,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginMode = true;
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSubmitting = true);

    // Persist the session + basic profile info so the user stays logged in
    // the next time they open the app.
    await AuthService.setLoggedIn(true);
    if (_nameController.text.trim().isNotEmpty) {
      await AuthService.saveProfileOverrides(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );
    } else if (_emailController.text.trim().isNotEmpty) {
      await AuthService.saveProfileOverrides(email: _emailController.text.trim());
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    widget.onAuthenticated();
  }

  InputDecoration _fieldDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF64748B)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.08),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppTheme.accentBlue, width: 1.5),
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/login_bg.jpg', fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xE60B0F19),
                  Color(0xCC0B0F19),
                  Color(0xF20B0F19),
                  Color(0xFF0B0F19),
                ],
                stops: [0.0, 0.3, 0.65, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    IconButton(
                      onPressed: widget.onBack,
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Image.asset('assets/images/logo.png', height: 64),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      _isLoginMode ? 'Welcome Back' : 'Create Account',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isLoginMode
                          ? 'Login to continue finding your dream car.'
                          : 'Sign up to start buying and selling cars.',
                      style: const TextStyle(fontSize: 14, color: Color(0xFFCBD5E1)),
                    ),
                    const SizedBox(height: 28),
                    if (!_isLoginMode) ...[
                      const Text('Full Name', style: _labelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _fieldDecoration('Enter your full name'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                      ),
                      const SizedBox(height: 16),
                    ],
                    const Text('Email', style: _labelStyle),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration('you@example.com'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Please enter your email';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Password', style: _labelStyle),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration(
                        'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: const Color(0xFF94A3B8),
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter your password';
                        if (v.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    if (_isLoginMode) ...[
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppTheme.accentBlue, fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                              )
                            : Text(
                                _isLoginMode ? 'Login' : 'Create Account',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.15))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('or continue with', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                        ),
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.15))),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(icon: Icons.g_mobiledata, color: const Color(0xFFEA4335)),
                        const SizedBox(width: 16),
                        _socialButton(icon: Icons.apple, color: Colors.black),
                        const SizedBox(width: 16),
                        _socialButton(icon: Icons.facebook, color: const Color(0xFF1877F2)),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLoginMode = !_isLoginMode),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 14, color: Color(0xFFCBD5E1)),
                            children: [
                              TextSpan(text: _isLoginMode ? "Don't have an account? " : 'Already have an account? '),
                              TextSpan(
                                text: _isLoginMode ? 'Sign Up' : 'Login',
                                style: const TextStyle(color: AppTheme.accentBlue, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton({required IconData icon, required Color color}) {
    return InkWell(
      onTap: _isSubmitting ? null : _submit,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

const _labelStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white);
