import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/authRepository.dart';
import 'package:trainer_app/global/loginApi.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/authRepository.dart'; // Asegúrate que el path sea correcto
import 'package:trainer_app/domain/repositories/exerciseRepository.dart';
import 'package:trainer_app/global/exerciseApi.dart';
import 'package:trainer_app/global/loginApi.dart';

// Definición del Service que agrupa repositorios
class ExerciseRepositoryService {
  final AuthRepository authRepository;
  final ExerciseRepository exerciseRepository;

  ExerciseRepositoryService({
    required this.authRepository, 
    required this.exerciseRepository
  });
}

// Provider global para acceder a todos los repositorios
final repositoryProvider = Provider<ExerciseRepositoryService>((ref) {
  // Instanciamos las dependencias
  final httpService = HttpService(); 
  final exerciseApi = ExerciseApi();

  final authRepository = AuthRepository(httpService);
  final exerciseRepository = ExerciseRepository(exerciseApi);

  return ExerciseRepositoryService(
    authRepository: authRepository,
    exerciseRepository: exerciseRepository,
  );
});