import 'package:flutter/material.dart';
import 'package:login_test/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider(
          create: (_)=> LoginFormProvider(),
          child: _LoginForm,
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFFC2E787)
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              
            ),
         ),
        ),
      ),
    );
  }
}