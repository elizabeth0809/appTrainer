import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/global/http.dart';

import '../repositories/authRepository.dart';

final repositoryProvider = Provider<RepositoryService>((ref){
  final authRepository = AuthRepository(HttpService());
  return RepositoryService(authRepository: authRepository);
});

class RepositoryService {
  final AuthRepository authRepository;
  RepositoryService({
    required this.authRepository
  });
}
