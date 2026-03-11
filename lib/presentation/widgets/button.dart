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
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white, 
                    ),
                    onPressed: () {
                      context.push(link);
                    },

                    child: Text(text),
                  ),
                );
  }
}