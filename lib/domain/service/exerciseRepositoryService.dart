import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/authRepository.dart';
import 'package:trainer_app/global/loginApi.dart';
import 'package:trainer_app/domain/repositories/exerciseRepository.dart';
import 'package:trainer_app/global/exerciseApi.dart';
class ExerciseRepositoryService {
  final AuthRepository authRepository;
  final ExerciseRepository exerciseRepository;

  ExerciseRepositoryService({
    required this.authRepository, 
    required this.exerciseRepository
  });
}
final repositoryProvider = Provider<ExerciseRepositoryService>((ref) {
  final httpService = HttpService(); 
  final exerciseApi = ExerciseApi();

  final authRepository = AuthRepository(httpService);
  final exerciseRepository = ExerciseRepository(exerciseApi);

  return ExerciseRepositoryService(
    authRepository: authRepository,
    exerciseRepository: exerciseRepository,
  );
});