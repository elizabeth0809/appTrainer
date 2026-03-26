import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/provider/openingProvider.dart';
import 'package:trainer_app/domain/service/openingRepositoryService.dart';

final openingControllerProvider =
    StateNotifierProvider<OpeningController, AsyncValue<void>>((ref) {
  return OpeningController(ref);
});

class OpeningController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  OpeningController(this.ref) : super(const AsyncData(null));

  Future<void> create(Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final token =
          ref.read(loginProvider).user?.accessToken ?? '';

      await ref
          .read(openingRepositoryProvider)
          .openingRepository
          .createOpening(token, body);

      ref.invalidate(openingFutureProvider); // 🔥 refresca lista
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> update(int id, Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final token =
          ref.read(loginProvider).user?.accessToken ?? '';

      await ref
          .read(openingRepositoryProvider)
          .openingRepository
          .updateOpening(token, id, body);

      ref.invalidate(openingFutureProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> delete(int id) async {
    state = const AsyncLoading();
    try {
      final token =
          ref.read(loginProvider).user?.accessToken ?? '';

      await ref
          .read(openingRepositoryProvider)
          .openingRepository
          .deleteOpening(token, id);

      ref.invalidate(openingFutureProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}