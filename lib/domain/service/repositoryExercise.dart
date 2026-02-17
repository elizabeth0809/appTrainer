import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/exerciseRegisterRepository.dart';
import 'package:trainer_app/global/exerciseApi.dart';

/*final repositoryExerciseProvider = Provider<RepositoryExerciseService>((ref){
  final authExerciseRepository = ExerciseRegisterRepository(ExerciseApi());
  return RepositoryExerciseService(authExerciseRepository: authExerciseRepository);
});

class RepositoryExerciseService {
  final ExerciseRegisterRepository authExerciseRepository;
  RepositoryExerciseService({
    required this.authExerciseRepository
  });
}*/