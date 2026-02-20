import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/provider/exerciseProvider.dart';
import 'package:trainer_app/domain/provider/secureStorageProvider.dart';

import '../domain/models/exerciseModel.dart';

class ExerciseServiceNotifier extends StateNotifier<ExercisesState> {
  final Ref ref;
  final String _baseUrl = '192.168.15.90:8000';

  ExerciseServiceNotifier(this.ref) : super(ExercisesState(isLoading: true)) {
    loadExercises();
  }

  Future<void> loadExercises() async {
  try {
    state = state.copyWith(isLoading: true, clearError: true);

    final token = await ref.read(secureStorageProvider).read(key: 'token');

    final url = Uri.http(_baseUrl, '/api/exercise/');

    final resp = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

print('STATUS CODE: ${resp.statusCode}');
//print('BODY: ${resp.body}');
    if (resp.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(resp.body);

      final exercises =
          decodedData.map((e) => Exercise.fromJson(e)).toList();

      state = state.copyWith(
        exercises: exercises,
        isLoading: false,
      );
    } else {
      throw Exception('Error al cargar exercises');
    }
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: e.toString(),
    );
  }
}


  Future<void> saveOrCreateExercise(Exercise exercise) async {
    try {
      state = state.copyWith(isSaving: true, errorMessage: null);
      
      if (exercise.id == 0) {
        await createExercise(exercise);
      } else {
        await updateExercise(exercise);
      }
      
      state = state.copyWith(isSaving: false);
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateExercise(Exercise exercise) async {
  final token = await ref.read(secureStorageProvider).read(key: 'token');

  final url = Uri.http(_baseUrl, '/api/exercise/${exercise.id}');

  final resp = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: json.encode(exercise.toJson()),
  );

  if (resp.statusCode == 200) {
    final updatedList = state.exercises
        .map((e) => e.id == exercise.id ? exercise : e)
        .toList();

    state = state.copyWith(exercises: updatedList);
  } else {
    throw Exception('Error al actualizar exercise');
  }
}


  Future<void> createExercise(Exercise exercise) async {
  final token = await ref.read(secureStorageProvider).read(key: 'token');

  final url = Uri.http(_baseUrl, '/api/exercise/');

  final resp = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: json.encode(exercise.toJson()),
  );

  if (resp.statusCode == 201 || resp.statusCode == 200) {
    final decodedData = json.decode(resp.body);

    final newExercise = Exercise.fromJson(decodedData);

    state = state.copyWith(
      exercises: [...state.exercises, newExercise],
    );
  } else {
    throw Exception('Error al crear exercise');
  }
}


  void selectExercise(Exercise exercise) {
    state = state.copyWith(selectedExercise: exercise);
  }

  void updateSelectedExerciseImage(String path) {
  if (state.selectedExercise != null) {
    final updatedExercise = state.selectedExercise!.copyWith(img: path);
    
    // Solo crear File si es una ruta local (no una URL)
    File? newFile;
    if (path.startsWith('/') || path.startsWith('file://')) {
      newFile = File(path);
    }
    
    state = state.copyWith(
      selectedExercise: updatedExercise,
      newPictureFile: newFile,
    );
  }
}

  Future<String?> uploadImage() async {
  if (state.newPictureFile == null) return null;
  
  try {
    state = state.copyWith(isSaving: true);
    
    // Verificar que el archivo existe antes de subirlo
    final file = state.newPictureFile!;
    if (!await file.exists()) {
      print('El archivo no existe: ${file.path}');
      state = state.copyWith(isSaving: false, newPictureFile: null);
      return null;
    }
    
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dtxguigqs/image/upload');
    
    final imageUploadRequest = http.MultipartRequest('POST', url);
    
    // Usar la ruta del archivo directamente
    final multipartFile = await http.MultipartFile.fromPath(
      'file', 
      file.path,
      filename: 'exercise_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    imageUploadRequest.files.add(multipartFile);
    
    // Agregar los parámetros de autenticación de Cloudinary
    imageUploadRequest.fields['upload_preset'] = 'tu_upload_preset'; // Si usas upload preset
    // O usar autenticación básica
    imageUploadRequest.headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('417568263796896:I_ui5iN5-uz9CJQZajZEvToxhfw'))}',
    });
    
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error al subir imagen: ${resp.body}');
      state = state.copyWith(isSaving: false);
      return null;
    }
    
    final decodedData = json.decode(resp.body);
    
    state = state.copyWith(
      isSaving: false,
      newPictureFile: null,
    );
    
    return decodedData['secure_url'];
  } catch (e) {
    print('Error al subir imagen: $e');
    state = state.copyWith(isSaving: false);
    return null;
  }
}

void clearSelectedExercise() {
  state = state.copyWith(
    clearSelected: true,
  );
}
}

final exerciseServiceProvider = StateNotifierProvider<ExerciseServiceNotifier, ExercisesState>((ref) {
  return ExerciseServiceNotifier(ref);
});
