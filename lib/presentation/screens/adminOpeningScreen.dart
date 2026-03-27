import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/provider/openingProvider.dart';
import 'package:trainer_app/domain/service/openingRepositoryService.dart';
import 'package:trainer_app/domain/controller/openingController.dart';

class AdminOpeningScreen extends ConsumerWidget {
  const AdminOpeningScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final openingAsync = ref.watch(openingFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horarios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
      ),

      floatingActionButton: FloatingActionButton(
  onPressed: () {
    showCreateOpeningForm(context, ref);
  },
  child: const Icon(Icons.add),
),

      body: openingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (err, _) => Center(
          child: Text('Error: $err'),
        ),

        data: (schedules) {
          if (schedules.isEmpty) {
            return const Center(
              child: Text('No hay horarios'),
            );
          }

          return ListView.builder(
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

                  // 🏷 nombre
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // 📋 info
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text("📅 Día: ${getDay(item.day)}"),
                      Text(
                        "⏰ ${item.startTime} - ${item.endtime}",
                      ),
                    ],
                  ),

                  trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    // ✏️ EDITAR
    IconButton(
      icon: const Icon(Icons.edit, color: Colors.green),
      onPressed: () {
        showEditOpeningForm(context, ref, item);
      },
    ),

    // 🗑 DELETE
    IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Eliminar'),
            content: const Text('¿Seguro?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(openingControllerProvider.notifier)
                      .delete(item.id);

                  Navigator.pop(context);
                },
                child: const Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    ),
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
void showEditOpeningForm(
  BuildContext context,
  WidgetRef ref,
  dynamic item,
) {
  final nameController = TextEditingController(text: item.name);
  String selectedDay = item.day;

  TimeOfDay startTime = TimeOfDay(
    hour: int.parse(item.startTime.split(':')[0]),
    minute: int.parse(item.startTime.split(':')[1]),
  );

  TimeOfDay endTime = TimeOfDay(
    hour: int.parse(item.endtime.split(':')[0]),
    minute: int.parse(item.endtime.split(':')[1]),
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Editar horario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                // 🏷 NAME
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                // 📅 DAY
                DropdownButtonFormField<String>(
                  value: selectedDay,
                  items: const [
                    DropdownMenuItem(value: 'mon', child: Text('Lunes')),
                    DropdownMenuItem(value: 'tue', child: Text('Martes')),
                    DropdownMenuItem(value: 'wed', child: Text('Miércoles')),
                    DropdownMenuItem(value: 'thu', child: Text('Jueves')),
                    DropdownMenuItem(value: 'fri', child: Text('Viernes')),
                    DropdownMenuItem(value: 'sat', child: Text('Sábado')),
                    DropdownMenuItem(value: 'sun', child: Text('Domingo')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedDay = value!);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Día',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                // ⏰ START
                ListTile(
                  title: Text(
                    'Inicio: ${startTime.format(context)}',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (picked != null) {
                      setState(() => startTime = picked);
                    }
                  },
                ),

                // ⏰ END
                ListTile(
                  title: Text(
                    'Fin: ${endTime.format(context)}',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (picked != null) {
                      setState(() => endTime = picked);
                    }
                  },
                ),

                const SizedBox(height: 16),

                // 💾 UPDATE
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) return;

                      String formatTime(TimeOfDay t) {
                        return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
                      }

                      ref.read(openingControllerProvider.notifier).update(
                        item.id,
                        {
                          "name": nameController.text,
                          "day": selectedDay,
                          "start_time": formatTime(startTime),
                          "endtime": formatTime(endTime),
                        },
                      );

                      Navigator.pop(context);
                    },
                    child: const Text('Actualizar'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
void showCreateOpeningForm(BuildContext context, WidgetRef ref) {
  final nameController = TextEditingController();
  String selectedDay = 'mon';
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Crear horario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedDay,
                  items: const [
                    DropdownMenuItem(value: 'mon', child: Text('Lunes')),
                    DropdownMenuItem(value: 'tue', child: Text('Martes')),
                    DropdownMenuItem(value: 'wed', child: Text('Miércoles')),
                    DropdownMenuItem(value: 'thu', child: Text('Jueves')),
                    DropdownMenuItem(value: 'fri', child: Text('Viernes')),
                    DropdownMenuItem(value: 'sat', child: Text('Sábado')),
                    DropdownMenuItem(value: 'sun', child: Text('Domingo')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedDay = value!);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Día',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),
                ListTile(
                  title: Text(
                    startTime == null
                        ? 'Hora inicio'
                        : 'Inicio: ${startTime!.format(context)}',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() => startTime = picked);
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    endTime == null
                        ? 'Hora fin'
                        : 'Fin: ${endTime!.format(context)}',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() => endTime = picked);
                    }
                  },
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          startTime == null ||
                          endTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Completa todos los campos')),
                        );
                        return;
                      }

                      String formatTime(TimeOfDay t) {
                        return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
                      }

                      ref.read(openingControllerProvider.notifier).create({
                        "name": nameController.text,
                        "day": selectedDay,
                        "start_time": formatTime(startTime!),
                        "endtime": formatTime(endTime!),
                      });

                      Navigator.pop(context);
                    },
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}