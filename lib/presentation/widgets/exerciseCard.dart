import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/controller/userSchedulingController.dart';

class ExerciseCard extends ConsumerStatefulWidget {
  const ExerciseCard({super.key});

  @override
  ConsumerState<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends ConsumerState<ExerciseCard> {
  @override
  void initState() {
    super.initState();
    // Ejecutar después del primer frame para evitar conflictos de construcción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userSchedulingProvider.notifier).getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userSchedulingProvider);
    final userSchedulings = state.userS;

    if (userSchedulings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userSchedulings.length,
      itemBuilder: (ctx, index) {
        final userScheduling = userSchedulings[index];
       return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userScheduling.exercise.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Modalidad: ${userScheduling.exercise.modalities}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Dia: ${userScheduling.openingSchedule.day}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*const SizedBox(width: 16),
                        Text(
                          'End: ${userScheduling.endTime}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.green),
                  ),
                  IconButton(
  icon: const Icon(Icons.delete, color: Colors.red),
  onPressed: () {
    // Mostrar un diálogo de confirmación es una buena práctica
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar agendamiento?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed:() => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(userSchedulingProvider.notifier).deleteScheduling(userScheduling.id);
              Navigator.pop(context);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
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
        );
      },
    );
  }
}

