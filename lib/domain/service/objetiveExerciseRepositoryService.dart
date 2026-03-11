import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/authRepository.dart';
import 'package:trainer_app/domain/repositories/objetiveRepository.dart';
import 'package:trainer_app/global/loginApi.dart';
import 'package:trainer_app/global/objetiveExerciseApi.dart';

class ObjetiveExerciseRepositoryService {
  final AuthRepository authRepository;
  final ObjetiveExerciseRepository objetiveExerciseRepository;

  ObjetiveExerciseRepositoryService({
    required this.authRepository, 
    required this.objetiveExerciseRepository
  });
}

// Provider global para acceder a todos los repositorios
final objetiveExerciserepositoryProvider = Provider<ObjetiveExerciseRepositoryService>((ref) {
  // Instanciamos las dependencias
  final httpService = HttpService(); 
  final objetiveExerciseApi = ObjetiveExerciseApi();

  final authRepository = AuthRepository(httpService);
  final objetiveexerciseRepository = ObjetiveExerciseRepository(objetiveExerciseApi);

  return ObjetiveExerciseRepositoryService(
    authRepository: authRepository,
    objetiveExerciseRepository: objetiveexerciseRepository,
  );
});