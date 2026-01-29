import 'package:flutter/material.dart';
import 'package:trainer_app/presentation/widgets/backgroundImage.dart';

class Forgetscreen extends StatelessWidget {
  const Forgetscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Contrasena')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackgroundImage(),
            const SizedBox(height: 20),
            Text(
              'Recupera tu contrasena',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Ingresa tu correo en el campo',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
          ],
        ),
      ),
    );
  }
}
