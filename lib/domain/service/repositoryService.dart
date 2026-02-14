import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/userSchudelingRepository.dart';
import 'package:trainer_app/global/http.dart';
import 'package:trainer_app/global/userSchudelingApi.dart';

import '../repositories/authRepository.dart';

final repositoryProvider = Provider<RepositoryService>((ref){
  final authRepository = AuthRepository(HttpService());
  final userSRepository = UserSchudelingRepository(UserSchudelingApi());
  return RepositoryService(
    authRepository: authRepository,
    userSRepository: userSRepository);
});

class RepositoryService {
  final AuthRepository authRepository;
  final UserSchudelingRepository userSRepository;
  RepositoryService({
    required this.authRepository, required this.userSRepository
  });
}
