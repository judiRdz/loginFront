import 'package:flutter/material.dart';
import 'package:login_test/providers/login_form_provider.dart';
import 'package:login_test/services/auth_services.dart';
import 'package:login_test/services/notifications_services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          child: _LoginForm(),
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
          decoration: const BoxDecoration(color: Color(0xFFC2E787)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Container(
                  width: size.width * 0.80,
                  height: size.height * 0.17,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      //TODO: poner una imagen
                      //image: DecorationImage(image: ...)
                      ),
                ),
                Container(
                  width: size.width * 0.80,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'ejemplo@correo.com',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 255, 244)),
                  ),
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El valor ingresado no es un correo';
                  },
                ),
                TextFormField(
                  autocorrect: false,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '***********',
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 255, 244)),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 8)
                        ? null
                        : 'La contrase;a debe ser mayor a 7 caracteres';
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Olvidaste tu contraseña?',
                      style:
                          TextStyle(color: Color.fromARGB(255, 2555, 255, 244)),
                    )),
                ElevatedButton(
                    onPressed: loginForm.isLoading
                        ? null
                        : () async {
                            final authService = Provider.of<AuthServices>(
                                context,
                                listen: false);
                            if (!loginForm.isValidForm()) return;
                            final String? errorMessage = await authService
                                .login(loginForm.email, loginForm.password);
                            if (errorMessage == null) {
                              Navigator.pushReplacementNamed(context, 'home');
                            } else {
                              NotificationServices.showSnackBar(errorMessage);
                              loginForm.isLoading = false;
                            }
                          },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const  Color.fromARGB(255, 255, 255, 244))),
                    child: const Text(
                      'iniciar sesion',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 96, 100, 93)),
                    )
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 244, 244)
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'register', arguments: '');
                    },
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 96, 108, 93),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
