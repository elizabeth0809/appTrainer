import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/enum/ui_state.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/provider/userProvider.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onPressed
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ref) {
    final isLoading = ref.watch(
      loginProvider.select((value) => value.uiState == UiState.loading),
    );
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        key: key,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, 
        ),
        onPressed: isLoading
    ? null
    : () async {
        try {
          await ref.read(loginProvider.notifier).login(
          emailController.text,
          passwordController.text,
        );
          final user = ref.read(loginProvider).user;
          if (user != null) {
      ref.read(userProvider.notifier).state = user;
    }
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$err')),
          );
        }
      },
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text('Entrar'),
      ),
    );
  }
}
