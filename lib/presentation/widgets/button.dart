import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonBlue extends StatelessWidget {
  final String link;
  final String text;
  const ButtonBlue({super.key, required this.link, required this.text});

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
                      context.push(link);
                    },

                    child: Text(text),
                  ),
                );
  }
}