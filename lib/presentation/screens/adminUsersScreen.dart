import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/provider/provider.dart';


class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(usersFutureProvider),
          )
        ],
      ),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (err, _) => Center(child: Text('Error: $err')),

        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('No hay usuarios'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final profile = user['profile'];
              final measurement = user['user_measurement'];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),

                  title: Text(
                    user['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      Text("📧 ${user['email']}"),
                      Text("🔑 Rol: ${user['role']}"),

                      if (profile != null) ...[
                        const SizedBox(height: 6),
                        Text("📱 Tel: ${profile['phone']}"),
                        Text("🎂 Nacimiento: ${profile['birthdate']}"),
                      ],

                      if (measurement != null) ...[
                        const SizedBox(height: 6),
                        Text("⚖ Peso: ${measurement['weight']}"),
                        Text("📏 Altura: ${measurement['height']}"),
                        Text("🏋 Nivel: ${measurement['level']}"),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}