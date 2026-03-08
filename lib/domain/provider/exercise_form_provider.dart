import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:trainer_app/domain/models/exerciseModel.dart';


class ExerciseFormState {
  final GlobalKey<FormState> formKey;
  final Exercise exercise;

  ExerciseFormState({
    required this.formKey,
    required this.exercise,
  });

  ExerciseFormState copyWith({
    GlobalKey<FormState>? formKey,
    Exercise? exercise,
  }) {
    return ExerciseFormState(
      formKey: formKey ?? this.formKey,
      exercise: exercise ?? this.exercise,
    );
  }
}

class ExerciseFormNotifier extends StateNotifier<ExerciseFormState> {
  ExerciseFormNotifier()
      : super(
          ExerciseFormState(
            formKey: GlobalKey<FormState>(),
            exercise: Exercise(
              name: "",
              price: 0,
              img: "",
              modalities: "",
            ),
          ),
        );

  void updateName(String value) {
    state = state.copyWith(
      exercise: state.exercise.copyWith(name: value),
    );
  }

  void updatePrice(String value) {
    state = state.copyWith(
      exercise: state.exercise.copyWith(price: int.tryParse(value) ?? 0),
    );
  }

  void updateModalities(String value) {
    state = state.copyWith(
      exercise: state.exercise.copyWith(modalities: value),
    );
  }
void updateExercise(Exercise exercise) {
  state = state.copyWith(
    exercise: exercise,
  );
}
  bool validate() {
    return state.formKey.currentState?.validate() ?? false;
  }
}

final exerciseFormProvider =
    StateNotifierProvider<ExerciseFormNotifier, ExerciseFormState>(
        (ref) => ExerciseFormNotifier());