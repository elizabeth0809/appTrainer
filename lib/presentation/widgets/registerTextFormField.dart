import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterTextFormField extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController password_confirmation;
  const RegisterTextFormField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.password_confirmation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //name
        TextFormField(
          controller: nameController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: 'Nombre Completo',
            prefixIcon: Icon(Icons.account_box),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa tu nombre';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
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
        //confirm
        const SizedBox(height: 16),
        TextFormField(
          controller: password_confirmation,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
            labelText: 'Confirma tu contrasena',
            prefixIcon: Icon(Icons.password),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa tu contrasena';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
