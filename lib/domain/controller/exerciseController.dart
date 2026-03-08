import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/models/exerciseModel.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/provider/secureStorageProvider.dart';
import 'package:trainer_app/domain/repositories/exerciseRepository.dart';
import 'package:trainer_app/domain/service/exerciseRepositoryService.dart';
import 'package:trainer_app/domain/service/repositoryService.dart';
import 'package:trainer_app/global/exerciseApi.dart';
// domain/provider/exercise_provider.dart
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
    Exercise? selectedExercise,
    File? newPictureFile,
    bool clearSelected = false,
  }) => ExercisesState(
    exercises: exercises ?? this.exercises,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
    errorMessage: errorMessage,
    selectedExercise: clearSelected ? null : (selectedExercise ?? this.selectedExercise),
    newPictureFile: newPictureFile ?? this.newPictureFile,
  );
}

class ExerciseNotifier extends StateNotifier<ExercisesState> {
  final ExerciseRepository repository;
  final Ref ref;

  ExerciseNotifier(this.repository, this.ref) : super(ExercisesState()) {
    loadExercises();
  }

  Future<String> _getToken() async {
    return await ref.read(secureStorageProvider).read(key: 'token') ?? '';
  }

  Future<void> loadExercises() async {
    state = state.copyWith(isLoading: true);
    try {
      final token = await _getToken();
      final list = await repository.getAll(token);
      state = state.copyWith(exercises: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> saveOrCreateExercise(Exercise exercise) async {
    state = state.copyWith(isSaving: true);
    try {
      final token = await _getToken();
      
      // 1. Si hay una imagen nueva, subirla primero a Cloudinary
      String? imageUrl = exercise.img;
      if (state.newPictureFile != null) {
        imageUrl = await _uploadToCloudinary(state.newPictureFile!);
      }

      final exerciseToSave = exercise.copyWith(img: imageUrl);

      if (exerciseToSave.id == null || exerciseToSave.id == 0) {
        final newEx = await repository.create(exerciseToSave, token);
        state = state.copyWith(exercises: [...state.exercises, newEx]);
      } else {
        final updatedEx = await repository.update(exerciseToSave, token);
        state = state.copyWith(
          exercises: state.exercises.map((e) => e.id == updatedEx.id ? updatedEx : e).toList()
        );
      }
      state = state.copyWith(isSaving: false, newPictureFile: null);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<String?> _uploadToCloudinary(File file) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dtxguigqs/image/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'appTrainer_upload'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());
      return data['secure_url'];
    }
    return null;
  }

  void onFileChanged(String path) {
    state = state.copyWith(newPictureFile: File(path));
  }
}

// El Provider final
final exerciseProvider = StateNotifierProvider<ExerciseNotifier, ExercisesState>((ref) {
  final repo = ExerciseRepository(ExerciseApi());
  return ExerciseNotifier(repo, ref);
});
