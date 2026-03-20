import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class PermissionsScreen extends ConsumerWidget { // Cambiado a ConsumerWidget
  const PermissionsScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profileControllerProvider);
    final user = ref.watch(loginProvider).user?.data;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Oi, ${user?.name ?? "Usuario"}'),
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
           Text(
              'Informacion personal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              selectionColor:  Theme.of(context).colorScheme.surface,
            ),
            const Divider(height: 24),
            // Mostrar datos del Perfil
            Infocard(),
            const SizedBox(height: 20),
            MeasurementCard(),
            const SizedBox(height: 20),
            permissionsCard(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(loginProvider.notifier).logout(); // 👈 AQUÍ SE USA
                    ref.invalidate(profileControllerProvider);
                    context.push('/');
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
                Image.asset('assets/off.png', width: 20)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
