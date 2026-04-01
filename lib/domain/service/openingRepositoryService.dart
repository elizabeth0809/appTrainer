import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/repositories/repository.dart';
import 'package:trainer_app/global/global.dart';


class OpeningRepositoryService {
  final OpeningRepository openingRepository;
  OpeningRepositoryService({
    required this.openingRepository
  });
}
final openingRepositoryProvider = Provider<OpeningRepositoryService>((ref) {
  final openingApi = OpeningApi();
  final openingRepository = OpeningRepository(openingApi);

  return OpeningRepositoryService(
    openingRepository: openingRepository,
  );
});