// providers/exercise_form_provider.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trainer_app/domain/models/model.dart';

class ExercisesState {
  final List<Exercise> exercises;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;
  final Exercise? selectedExercise;
  final File? newPictureFile;

  ExercisesState({
    this.exercises = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
    this.selectedExercise,
    this.newPictureFile,
  });

  ExercisesState copyWith({
    List<Exercise>? exercises,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
    Exercise? selectedExercise,
    bool clearSelected = false,
    File? newPictureFile,
  }) {
    return ExercisesState(
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      selectedExercise:
          clearSelected ? null : selectedExercise ?? this.selectedExercise,
      newPictureFile: newPictureFile ?? this.newPictureFile,
    );
  }
}

// State para el formulario
class ExerciseFormState {
  final GlobalKey<FormState> formKey;
  final Exercise exercise;
  final bool isValid;
  final bool isInitialized;

  ExerciseFormState({
    required this.formKey,
    required this.exercise,
    this.isValid = false,
    this.isInitialized = false,
  });

  ExerciseFormState copyWith({
    GlobalKey<FormState>? formKey,
    Exercise? exercise,
    bool? isValid,
    bool? isInitialized,
  }) {
    return ExerciseFormState(
      formKey: formKey ?? this.formKey,
      exercise: exercise ?? this.exercise,
      isValid: isValid ?? this.isValid,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

// Provider del formulario
class ExerciseFormNotifier extends StateNotifier<ExerciseFormState> {
  ExerciseFormNotifier() : super(ExerciseFormState(
    formKey: GlobalKey<FormState>(),
    exercise: Exercise(id: 0, name: '', price: 0, img: '', modalities: ''),
  ));

  void updateExercise(Exercise exercise) {
    state = state.copyWith(
      exercise: exercise,
      isInitialized: true,
    );
  }

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

  void updateImg(String value) {
    state = state.copyWith(
      exercise: state.exercise.copyWith(img: value),
    );
  }

  bool isValidForm() {
    final isValid = state.formKey.currentState?.validate() ?? false;
    state = state.copyWith(isValid: isValid);
    return isValid;
  }
}

final exerciseFormProvider = StateNotifierProvider<ExerciseFormNotifier, ExerciseFormState>((ref) {
  return ExerciseFormNotifier();
});