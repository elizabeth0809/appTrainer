import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/openingRepository.dart';
import 'package:trainer_app/global/openingApi.dart';

class OpeningRepositoryService {
  final OpeningRepository openingRepository;

  OpeningRepositoryService({
    required this.openingRepository
  });
}

// Provider global para acceder a todos los repositorios
final openingRepositoryProvider = Provider<OpeningRepositoryService>((ref) {
  // Instanciamos las dependencias
  final openingApi = OpeningApi();
  final openingRepository = OpeningRepository(openingApi);

  return OpeningRepositoryService(
    openingRepository: openingRepository,
  );
});