import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/repositories/repository.dart';
import 'package:trainer_app/global/global.dart';

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
  final client = http.Client();
   final exerciseApi = ExerciseApi(client: client);

  final authRepository = AuthRepository(httpService);
  final exerciseRepository = ExerciseRepository(exerciseApi);

  return ExerciseRepositoryService(
    authRepository: authRepository,
    exerciseRepository: exerciseRepository,
  );
});