import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/provider/userProvider.dart';
import 'package:trainer_app/global/loginApi.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  @override
  void initState() {
    emailController.text = 'admin@example.com';
    passwordController.text = '12345678';

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

final httpService = HttpService();

Future<void> handleLogin() async {
  try {
    final body = jsonEncode({
      "email": emailController.text,
      "password": passwordController.text,
    });

    final response = await httpService.login(body);
    final user = User.fromJson(response);
    ref.read(userProvider.notifier).state = user;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Título
                Text(
                  'Bienvenido',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 10),
                Text(
                  'Ingresa a tu cuenta para continuar tu entrenamiento',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                LoginTextFormField(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                Row(
                  children: [
                    /* Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),*/
                    const Text('Recordarme'),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        context.push('/forget');
                        // Navigator.pushNamed(context, '/forget');
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                LoginButton(
                  emailController: emailController,
                  passwordController: passwordController,
                 onPressed: handleLogin
                  ),
                const SizedBox(height: 16),
                // Texto registro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?'),

                    TextButton(
                      onPressed: () {
                        context.push('/register');
                      },
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
