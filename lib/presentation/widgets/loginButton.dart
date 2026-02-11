import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';

class LoginButton extends ConsumerWidget {
   const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Fondo azul
              foregroundColor: Colors.white, // Texto e íconos blancos
            ),
            onPressed: () async {
              ref
                  .read(loginProvider.notifier)
                  .login(emailController.text, passwordController.text)
                  .then((value){
                     Navigator.of(context).push(MaterialPageRoute(builder: (_) =>Scaffold(body: SizedBox(),) ));
                  })
                  .catchError((err, stackTrace){
                    print(err);
                  });
             
              /* if (formKey.currentState!.validate()) {
                        // TODO: lógica de login
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login válido')),
                        );
                      }*/
            },

            child: Text('Entrar'),
          ),
        );
  }
}