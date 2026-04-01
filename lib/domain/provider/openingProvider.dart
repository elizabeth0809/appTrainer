import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/models/openingScheduleModel.dart';
import 'package:trainer_app/domain/provider/provider.dart';
import 'package:trainer_app/domain/service/service.dart';


final openingFutureProvider = FutureProvider<List<OpeningSchedule>>((ref) async {
  final token = ref.watch(loginProvider.select((v) => v.user?.accessToken ?? ''));
  final repo = ref.watch(openingRepositoryProvider).openingRepository;
  return await repo.getAllOpeningApi(token);
});