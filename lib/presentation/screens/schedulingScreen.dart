import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/exerciseApi.dart';

class SchedulingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesState = ref.watch(exerciseServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Exercises')),
      body: exercisesState.isLoading
          ? Center(child: CircularProgressIndicator())
          : exercisesState.errorMessage != null
          ? Center(child: Text('Error: ${exercisesState.errorMessage}'))
          : ListView.builder(
              itemCount: exercisesState.exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercisesState.exercises[index];

                return GestureDetector(
                  onTap: () {
                    ref
                        .read(exerciseServiceProvider.notifier)
                        .selectExercise(exercise.copyWith());
                    context.push('/home/exercise');
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(exercise.name),
                      subtitle: Text('Price: \$${exercise.price}'),
                      trailing: Text(exercise.modalities),
                    ),
                  ),
                );
              },
            ),

     floatingActionButton: FloatingActionButton(
  child: const Icon(Icons.add),
  onPressed: () {

    final newExercise = Exercise(
      name: '',
      price: 0,
      img: '',
      modalities: '',
    );

    ref.read(exerciseServiceProvider.notifier)
        .selectExercise(newExercise);

   context.push('/home/exercise');
  },
),
    );
  }
}

/*  Widget _nextButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () {
            context.go('/home/editInfoId');
          },
          icon: const Text('Editar'),
          label: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}*/
