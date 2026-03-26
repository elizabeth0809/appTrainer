import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SchedulingUsersScreen extends StatelessWidget {
  const SchedulingUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "name": "Entrenamiento mañana",
        "scheduled_date": "2026-03-25",
        "exercise": {
          "name": "Yoga",
          "price": 30,
          "img":
              "https://images.unsplash.com/photo-1552196563-55cd4e45efb3",
          "modalities": "online"
        },
        "objective": {"name": "Relajación"},
        "schedule": {
          "start_time": "08:00",
          "endtime": "09:00"
        },
        "user": {"name": "Carlos"}
      },
      {
        "name": "Rutina intensa",
        "scheduled_date": "2026-03-26",
        "exercise": {
          "name": "Crossfit",
          "price": 50,
          "img":
              "https://images.unsplash.com/photo-1599058917765-a780eda07a3e",
          "modalities": "presencial"
        },
        "objective": {"name": "Ganar músculo"},
        "schedule": {
          "start_time": "10:00",
          "endtime": "11:30"
        },
        "user": {"name": "Ana"}
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamientos (Demo)'),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          final exercise = item['exercise'];
          final schedule = item['schedule'];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    exercise['img'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🏷 Nombre
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text("📅 Fecha: ${item['scheduled_date']}"),
                      Text("👤 Cliente: ${item['user']['name']}"),
                      Text("🏋️ Ejercicio: ${exercise['name']}"),
                      Text("🎯 Objetivo: ${item['objective']['name']}"),
                      Text(
                        "⏰ Horario: ${schedule['start_time']} - ${schedule['endtime']}",
                      ),
                      Text("💰 Precio: \$${exercise['price']}"),

                      const SizedBox(height: 8),

                      Chip(
                        label: Text(exercise['modalities']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}