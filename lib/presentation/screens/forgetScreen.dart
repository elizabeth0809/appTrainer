import 'package:flutter/material.dart';
import 'package:trainer_app/presentation/widgets/backgroundImage.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Contrasena')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackgroundImage('assets/contrasena.png'),
              const SizedBox(height: 20),
              Text(
                'Recupera tu contrasena',
                style: Theme.of(context).textTheme. titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'Ingresa tu correo en el campo para buscar tu cuenta.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
                TextFormField(
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
            // Botón login
                ButtonBlue(link: '/home', text: 'Recuperar',),
            ],
          ),
        ),
      ),
    );
  }
}
