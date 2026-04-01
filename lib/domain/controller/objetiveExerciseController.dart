import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:trainer_app/domain/provider/provider.dart';
import 'package:trainer_app/domain/service/service.dart';


final objetiveControllerProvider =
    StateNotifierProvider<ObjetiveController, AsyncValue<void>>((ref) {
  return ObjetiveController(ref);
});

class ObjetiveController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  ObjetiveController(this.ref) : super(const AsyncData(null));
Future<void> update(int id, Map<String, dynamic> body) async {
  state = const AsyncLoading();
  try {
    final token = ref.read(loginProvider).user?.accessToken ?? '';

    await ref
        .read(objetiveExerciserepositoryProvider)
        .objetiveExerciseRepository
        .updateObjetive(token, id, body);

    ref.invalidate(objetivosFutureProvider);
    state = const AsyncData(null);
  } catch (e, st) {
    state = AsyncError(e, st);
  }
}
  Future<void> create(Map<String, dynamic> body) async {
    state = const AsyncLoading();
    try {
      final token = ref.read(loginProvider).user?.accessToken ?? '';

      await ref
          .read(objetiveExerciserepositoryProvider)
          .objetiveExerciseRepository
          .createObjetive(token, body);

      ref.invalidate(objetivosFutureProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> delete(int id) async {
    state = const AsyncLoading();
    try {
      final token = ref.read(loginProvider).user?.accessToken ?? '';

      await ref
          .read(objetiveExerciserepositoryProvider)
          .objetiveExerciseRepository
          .deleteObjetive(token, id);

      ref.invalidate(objetivosFutureProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}