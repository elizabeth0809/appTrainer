import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/repository.dart';
import 'package:trainer_app/global/global.dart';


final repositoryRegisterProvider = Provider<RepositoryRegisterService>((ref){
  final authRegisterRepository = AuthRegisterRepository(HttpService());
  return RepositoryRegisterService(authRegisterRepository: authRegisterRepository);
});

class RepositoryRegisterService {
  final AuthRegisterRepository authRegisterRepository;
  RepositoryRegisterService({
    required this.authRegisterRepository
  });
}