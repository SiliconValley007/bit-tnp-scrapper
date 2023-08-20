import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnp_scanner/cubits/cookie_cubit/cookie_cubit.dart';

class CredentialsPage extends StatefulWidget {
  const CredentialsPage({super.key});

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const CredentialsPage());

  @override
  State<CredentialsPage> createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CookieCubit cookieCubit = context.read<CookieCubit>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text.rich(
                TextSpan(
                  text: 'Save',
                  children: [
                    TextSpan(
                      text: '\nyour credentials',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'make your life a little bit easier',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .7,
                ),
              ),
              const SizedBox(height: 8),
              _UsernameTextField(usernameController: _usernameController),
              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .7,
                ),
              ),
              const SizedBox(height: 8),
              _PasswordTextField(passwordController: _passwordController),
              const SizedBox(height: 40),
              BlocBuilder<CookieCubit, CookieState>(
                builder: (context, state) {
                  return _LoginButton(
                    isDisabled: cookieCubit.isLoggedIn,
                    onPressed: () {
                      final String username = _usernameController.text;
                      final String password = _passwordController.text;
                      log('$username: $password');
                      if (username.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter username and password.'),
                          ),
                        );
                      } else {
                        cookieCubit.login(
                            username: username, password: password);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CookieCubit, CookieState>(
      builder: (context, state) => TextField(
        enabled: !context.read<CookieCubit>().isLoggedIn,
        controller: _passwordController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Background color
          hintText: 'Enter your password',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20), // Rounded borders
          ),
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField({
    required TextEditingController usernameController,
  }) : _usernameController = usernameController;

  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CookieCubit, CookieState>(
      builder: (context, state) => TextField(
        enabled: !context.read<CookieCubit>().isLoggedIn,
        controller: _usernameController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Background color
          hintText: 'Enter your username',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20), // Rounded borders
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.onPressed,
    this.isDisabled = false,
  });

  final VoidCallback onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: isDisabled ? Colors.black38 : Colors.deepPurple,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        alignment: Alignment.center,
        child: Text(
          isDisabled ? 'Already logged in' : 'Login',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
