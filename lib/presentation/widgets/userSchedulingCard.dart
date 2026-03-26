import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/controller/userSchedulingController.dart';

class UserSchedulingCard extends ConsumerStatefulWidget {
  const UserSchedulingCard({super.key});

  @override
  ConsumerState<UserSchedulingCard> createState() => _UserSchedulingCardState();
}

class _UserSchedulingCardState extends ConsumerState<UserSchedulingCard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userSchedulingProvider.notifier).getMyScheduliung();
    });}

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userSchedulingProvider);
    final userSchedulings = state.userSMyList;
if (userSchedulings.isEmpty) {
     return const Center(
    child: Text('No hay agendamientos o no cargaron'),
  );
    }
    /*if (userSchedulings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }*/

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
                      userScheduling.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Modalidad: ${userScheduling.exerciseObjetiveExercise.exercise.modalities}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Objetivo: ${userScheduling.exerciseObjetiveExercise.objetiveExercise.name}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Row(
                      children: [
                        Text(
                          'Dia: ${userScheduling.openingSchedule.day}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

