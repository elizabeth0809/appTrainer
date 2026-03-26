import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminObjetiveScreen extends StatelessWidget {
  const AdminObjetiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Datos mock (tu JSON)
    final List<Map<String, dynamic>> objetives = [
      {"id": 1, "name": "Engordar"},
      {"id": 2, "name": "Adelgazar"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetivos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Crear Relacion')),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: objetives.length,
              itemBuilder: (context, index) {
                final obj = objetives[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        obj['id'].toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      obj['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
