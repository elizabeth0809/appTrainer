import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/exerciseController.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/provider/exerciseProvider.dart'
    hide ExercisesState;

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exerciseProvider);
    final notifier = ref.read(exerciseProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Ejercicios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.loadExercises(),
          ),
        ],
      ),
      body: _buildBody(state, notifier, context, ref),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Resetear el formulario con un ejercicio vacío
          ref
              .read(exerciseFormProvider.notifier)
              .updateExercise(
                Exercise(name: '', price: 0, img: '', modalities: ''),
              );
          context.push('/homeExercise/exercise');
        },
      ),
    );
  }

  Widget _buildBody(
    ExercisesState state,
    ExerciseNotifier notifier,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (state.isLoading)
      return const Center(child: CircularProgressIndicator());

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.loadExercises(),
      child: ListView.builder(
        itemCount: state.exercises.length,
        itemBuilder: (context, index) {
          final exercise = state.exercises[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(exercise.img)),
            title: Text(exercise.name),
            subtitle: Text('\$${exercise.price} - ${exercise.modalities}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ref.read(exerciseFormProvider.notifier).updateExercise(exercise);
              context.push('/home/exercise');
            },
          );
        },
      ),
    );
  }
}
