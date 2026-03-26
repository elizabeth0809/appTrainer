import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminOpeningScreen extends StatefulWidget {
  const AdminOpeningScreen({super.key});

  @override
  State<AdminOpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<AdminOpeningScreen> {
  List<Map<String, dynamic>> schedules = [
    {
      "id": 1,
      "name": "horario comercial",
      "day": "wed",
      "start_time": "07:30:00",
      "endtime": "20:00:00",
    },
    {
      "id": 2,
      "name": "horario lunes",
      "day": "mon",
      "start_time": "07:30:00",
      "endtime": "20:00:00",
    }
  ];


  void deleteSchedule(int id) {
    setState(() {
      schedules.removeWhere((item) => item['id'] == id);
    });
  }
  void createSchedule() {
    setState(() {
      schedules.add({
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": "nuevo horario",
        "day": "fri",
        "start_time": "08:00:00",
        "endtime": "18:00:00",
      });
    });
  }

  String getDay(String day) {
    switch (day) {
      case 'mon':
        return 'Lunes';
      case 'tue':
        return 'Martes';
      case 'wed':
        return 'Miércoles';
      case 'thu':
        return 'Jueves';
      case 'fri':
        return 'Viernes';
      case 'sat':
        return 'Sábado';
      case 'sun':
        return 'Domingo';
      default:
        return day;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createSchedule,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final item = schedules[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(
                item['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text("📅 Día: ${getDay(item['day'])}"),
                  Text(
                    "⏰ ${item['start_time']} - ${item['endtime']}",
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteSchedule(item['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}