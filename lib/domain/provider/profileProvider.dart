import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/repositories/profileRepository.dart';

final usersFutureProvider = FutureProvider<List<dynamic>>((ref) async {
  final token = ref.watch(loginProvider.select((v) => v.user?.accessToken ?? ''));
  final repo = ref.watch(profileRepositoryProvider);

  return await repo.getAllUsers(token);
});