import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_mobile/providers/auth_provider.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/views/components/common/app_toast.dart';
import 'package:wms_mobile/views/components/login/login_button.dart';
import 'package:wms_mobile/views/components/login/text_field_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthProvider>();
    _userController.text = auth.savedUsername.isEmpty ? 'r.santos' : auth.savedUsername;
    _passwordController.text = auth.savedUsername.isEmpty ? 'demo' : '';
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _userController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      AppToast.error(context, auth.error ?? 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;

    return Scaffold(
      backgroundColor: AppColorsConst.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColorsConst.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.warehouse_rounded,
                          color: AppColorsConst.onPrimary,
                          size: 36,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'WMS Mobile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColorsConst.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Warehouse operations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColorsConst.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFieldComponent(
                      controller: _userController,
                      label: 'Username',
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Username is required' : null,
                    ),
                    TextFieldComponent(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: _hidePassword,
                      onSubmitted: (_) => _login(),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => _hidePassword = !_hidePassword),
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColorsConst.textSecondary,
                        ),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Password is required' : null,
                    ),
                    const SizedBox(height: 16),
                    LoginButton(
                      onPressed: _login,
                      label: 'LOG IN',
                      loading: loading,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
