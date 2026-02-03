import 'package:flutter/material.dart';
import 'package:trainer_app/presentation/widgets/backgroundImage.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamiento Listo')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackgroundImage('assets/agenda.png'),
              const SizedBox(height: 20),
              Text(
                'Agendamiento',
                style: Theme.of(context).textTheme. titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'Ingresa tu correo en el campo para buscar tu cuenta.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
            // Botón login
                ButtonBlue(link: '/home', text: 'volver al inicio',),
            ],
          ),
        ),
      ),
    );
  }
}
