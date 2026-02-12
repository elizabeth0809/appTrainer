import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/enum/ui_state.dart';
import 'package:trainer_app/domain/provider/registerProvider.dart';
import 'package:trainer_app/presentation/screens/screen.dart';

class RegisterButton extends ConsumerWidget {
 

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController password_confirmation;
  const RegisterButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.password_confirmation,
  });
  @override
  Widget build(BuildContext context, ref) {
    final isLoading = ref.watch(RegisterProvider.select((value)=> value.uiState == UiState.loading));
    return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            key: key,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Fondo azul
              foregroundColor: Colors.white, // Texto e íconos blancos
            ),
            onPressed: isLoading ? null:() async {
              ref
                  .read(RegisterProvider.notifier)
                  .register(nameController.text,emailController.text, passwordController.text, password_confirmation.text)
                  .then((value){
                     Navigator.of(context).push(MaterialPageRoute(builder: (_) =>HomeScreen() ));
                  })
                  .catchError((err, stackTrace){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$err')));
                  });
         
            },

            child:isLoading? CircularProgressIndicator(color: Colors.white): Text('Entrar'),
          ),
        );
  }
}