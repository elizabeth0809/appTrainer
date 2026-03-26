import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/profileController.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/provider/userProvider.dart';

import 'package:trainer_app/presentation/widgets/widget.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administrador'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              // logout
              ref.read(loginProvider.notifier).logout();
              ref.read(userProvider.notifier).state = null;
               ref.invalidate(profileControllerProvider);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido, ${user?.data.name ?? ''}',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              'Rol: ${user?.data.role ?? ''}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  AdminCard(
                    title: 'Gestionar Agendamientos',
                    icon: Icons.people,
                    onTap: () {
                      context.go('/usersScheduling');
                    },
                  ),
                AdminCard(
                    title: 'Datos de Usuarios',
                    icon: Icons.data_usage_rounded,
                    onTap: () {
                      context.go('/dataUsers');
                    },
                  ),
                  AdminCard(
                    title: 'Gestionar objetivos',
                    icon: Icons.emoji_objects,
                    onTap: () {
                      context.go('/dataObjetive');
                    },
                  ),
                 AdminCard(
                    title: 'Crear Horarios',
                    icon: Icons.house_rounded,
                    onTap: () {
                    context.go('/dataOpening');
                    },
                  ),
                  AdminCard(
                    title: 'Crear ejercicios',
                    icon: Icons.fitness_center,
                    onTap: () {
                    context.go('/homeExercise');
                    },
                  ),

                  AdminCard(
                    title: 'Ver reportes',
                    icon: Icons.bar_chart,
                    onTap: () {
                      context.go('/reports');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}