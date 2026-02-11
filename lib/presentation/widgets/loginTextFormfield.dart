import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginTextFormField extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginTextFormField({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool rememberMe = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        // Email
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa tu correo';
            }
            if (!value.contains('@')) {
              return 'Correo no válido';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Password
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: Icon(Icons.lock_outline),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.length < 3) {
              return 'Mínimo 3 caracteres';
            }
            return null;
          },
        ),

        
      ],
    );
  }
}
