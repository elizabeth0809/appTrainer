import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  @override
  void initState() {
    emailController.text = 'mon3@correo.com';
    passwordController.text = '12345678';

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                LoginButton(emailController: emailController, passwordController: passwordController),
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
