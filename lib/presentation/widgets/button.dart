import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  const ButtonBlue({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Fondo azul
                      foregroundColor: Colors.white, // Texto e íconos blancos
                    ),
                    onPressed: () {
                     /* if (formKey.currentState!.validate()) {
                        // TODO: lógica de login
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login válido')),
                        );
                      }*/
                    },

                    child: const Text('Entrar'),
                  ),
                );
  }
}