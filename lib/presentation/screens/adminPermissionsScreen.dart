import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/provider/userProvider.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class AdminPermissionsScreen extends ConsumerWidget {
  const AdminPermissionsScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profileControllerProvider);
    final user = ref.watch(loginProvider).user?.data;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Oi, ${user?.name ?? "Usuario"}'),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
        actions: [
          CircleAvatar(child: Text(user?.name[0] ?? "U")),
          const SizedBox(width: 16),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  permissionsCard(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          ref.read(loginProvider.notifier).logout();
                          ref.read(userProvider.notifier).state = null;
                          ref.invalidate(profileControllerProvider);
                        },
                        child: const Text(
                          'Cerrar sesion',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Image.asset('assets/off.png', width: 20),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
