import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 DATA MOCK (tu JSON)
    final List<Map<String, dynamic>> users = [
      {
        "name": "eliza",
        "email": "mon4@correo.com",
        "role": "customer",
        "profile": {
          "phone": "1150245521",
          "birthdate": "2026-02-26",
        },
        "user_measurement": {
          "weight": 200,
          "height": 50,
          "gender": "female",
          "level": "advanced",
        }
      },
      {
        "name": "Admin",
        "email": "admin@example.com",
        "role": "admin",
        "profile": null,
        "user_measurement": null
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
      ),
      body: ListView.builder(
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
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👤 Nombre + Rol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        label: Text(user['role']),
                        backgroundColor: user['role'] == 'admin'
                            ? Colors.red.shade100
                            : Colors.blue.shade100,
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 📧 Email
                  Text("📧 ${user['email']}"),

                  const Divider(),

                  // 📱 Profile
                  Text(
                    "📱 Teléfono: ${profile?['phone'] ?? 'No disponible'}",
                  ),
                  Text(
                    "🎂 Nacimiento: ${profile?['birthdate'] ?? 'No disponible'}",
                  ),

                  const Divider(),

                  // ⚖️ Measurement
                  Text(
                    "⚖️ Peso: ${measurement?['weight'] ?? '-'}",
                  ),
                  Text(
                    "📏 Altura: ${measurement?['height'] ?? '-'}",
                  ),
                  Text(
                    "🚻 Género: ${measurement?['gender'] ?? '-'}",
                  ),
                  Text(
                    "📊 Nivel: ${measurement?['level'] ?? '-'}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}