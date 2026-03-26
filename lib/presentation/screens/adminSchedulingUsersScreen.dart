import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/userSchedulingController.dart';

class SchedulingUsersScreen extends ConsumerStatefulWidget {
  const SchedulingUsersScreen({super.key});

  @override
  ConsumerState<SchedulingUsersScreen> createState() => _SchedulingUsersScreenState();
}
 class _SchedulingUsersScreenState extends ConsumerState<SchedulingUsersScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(userSchedulingProvider.notifier).getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userSchedulingProvider);
    final schedulings = state.userS;

    if (schedulings.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No hay agendamientos')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamientos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: schedulings.length,
        itemBuilder: (context, index) {
          final item = schedulings[index];

          final exercise = item.exerciseObjetiveExercise.exercise;
          final objective = item.exerciseObjetiveExercise.objetiveExercise;
          final schedule = item.openingSchedule;
          final user = item.user;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text("Fecha: ${item.scheduledDate}"),
                      Text("Cliente: ${user.name}"),
                      Text("Ejercicio: ${exercise.name}"),
                      Text("Objetivo: ${objective.name}"),
                      Text(
                        "${schedule.startTime} - ${schedule.endtime}",
                      ),
                      Text("Precio: \$${exercise.price}"),

                      const SizedBox(height: 8),

                      Chip(
                        label: Text(exercise.modalities),
                      ),

                      const SizedBox(height: 10),

                      //BOTONES (EDIT / DELETE)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              // editar
                            },
                          ),
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
                                            .read(userSchedulingProvider.notifier)
                                            .deleteScheduling(item.id);
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