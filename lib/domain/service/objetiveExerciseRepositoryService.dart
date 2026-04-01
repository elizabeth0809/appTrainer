import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/repository.dart';
import 'package:trainer_app/global/global.dart';


class ObjetiveExerciseRepositoryService {
  final AuthRepository authRepository;
  final ObjetiveExerciseRepository objetiveExerciseRepository;

  ObjetiveExerciseRepositoryService({
    required this.authRepository, 
    required this.objetiveExerciseRepository
  });
}
final objetiveExerciserepositoryProvider = Provider<ObjetiveExerciseRepositoryService>((ref) {
  final httpService = HttpService(); 
  final objetiveExerciseApi = ObjetiveExerciseApi();

  final authRepository = AuthRepository(httpService);
  final objetiveexerciseRepository = ObjetiveExerciseRepository(objetiveExerciseApi);

  return ObjetiveExerciseRepositoryService(
    authRepository: authRepository,
    objetiveExerciseRepository: objetiveexerciseRepository,
  );
});