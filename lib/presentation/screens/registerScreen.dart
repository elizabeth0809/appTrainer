import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/presentation/widgets/backgroundImage.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController(),
                              passwordController = TextEditingController(),
                              nameController = TextEditingController(),
                              password_confirmation= TextEditingController();
  void initState() {
    nameController.text;
    emailController.text;
    passwordController.text;
    password_confirmation.text;

    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    password_confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrate')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Crea tu cuenta',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Comienza tu viaje hacia una mejor versión de ti mismo.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              RegisterTextFormField(
                emailController: emailController,
                passwordController: passwordController,
                nameController: nameController,
                password_confirmation: password_confirmation),
                  ObjetivoDropdown(),
                  const SizedBox(height: 36),
            // Botón login
               RegisterButton(emailController: emailController, passwordController: passwordController, nameController: nameController, password_confirmation: password_confirmation),
             const SizedBox(height: 36),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const Text('¿Ya tienes cuenta?'),
                
                TextButton(
                     onPressed: () {
                        context.push('/');
                      },
                  child: const Text('Inicia sesion',
                  style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15,
                        ),
                  ),
                ),
                ] 
               )
            ],
          ),
        ),
      ),
    );
  }
}
