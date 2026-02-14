import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/service/repositoryService.dart';

final userSchedulingProvider = StateNotifierProvider<UserSchedulingNotifier, UserSchedulingState>((ref) {
  final repository = ref.watch(repositoryProvider);
  // Usamos watch para que el provider reaccione a cambios de login
  final accessToken = ref.watch(loginProvider.select((value) => value.user?.accessToken ?? ''));

  return UserSchedulingNotifier(
    UserSchedulingState(accessToken: accessToken, userS: []),
    repository,
  );
});
class UserSchedulingState {
  final List<UserScheduling> userS;
  final String accessToken;

  UserSchedulingState({
    required this.userS,
    required this.accessToken,
  });

  UserSchedulingState copyWith({
    List<UserScheduling>? userS,
    String? accessToken,
  }) {
    return UserSchedulingState(
      userS: userS ?? this.userS,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
class UserSchedulingNotifier extends StateNotifier<UserSchedulingState> {
  final RepositoryService repositoryService;

  UserSchedulingNotifier(super.state, this.repositoryService);

  Future<void> getAll() async {
    try {
      // 1. Llamamos a la API
      final userSList = await repositoryService.userSRepository.getAll(state.accessToken);
      
      // 2. IMPORTANTE: Actualizar el estado
      state = state.copyWith(userS: userSList);
      
    } catch (e) {
      // Considera manejar el error aquí o guardarlo en el estado
      debugPrint("Error al obtener datos: $e");
    }
  }
}