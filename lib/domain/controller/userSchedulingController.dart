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
    UserSchedulingState(accessToken: accessToken, userS: [], userSMyList: []),
    repository,
  );
});
class UserSchedulingState {
  final List<Datum> userS;
  final List<MySchedulingDatum> userSMyList;
  final String accessToken;

  UserSchedulingState({
    required this.userS,
     required this.userSMyList,
    required this.accessToken,
  });

  UserSchedulingState copyWith({
    List<Datum>? userS,
    List<MySchedulingDatum>? userSMyList,
    String? accessToken,
  }) {
    return UserSchedulingState(
      userS: userS ?? this.userS,
      userSMyList: userSMyList ?? this.userSMyList,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
class UserSchedulingNotifier extends StateNotifier<UserSchedulingState> {
  final RepositoryService repositoryService;

  UserSchedulingNotifier(super.state, this.repositoryService);
Future<void> createScheduling(Map<String, dynamic> schedulingData) async {
  try {
    final newDatum = await repositoryService.userSRepository.create(schedulingData, state.accessToken);
    // Agregamos al estado localmente
    state = state.copyWith(userS: [...state.userS, newDatum]);
  } catch (e) {
    debugPrint("Error al crear agendamiento: $e");
  }
}
  Future<void> getAll() async {
  try {
    print("Iniciando carga de scheduling...");
    final userSList = await repositoryService.userSRepository.getAll(state.accessToken);
    print("Datos recibidos: ${userSList.length} elementos"); // Si esto no se imprime, el error está antes
    state = state.copyWith(userS: userSList); 
  } catch (e, stackTrace) {
    print("Error exacto: $e");
    print("Stacktrace: $stackTrace");
  }
}
Future<void> getMyScheduliung() async {
  try {
    print("Iniciando carga de scheduling...");
    final userSMy = await repositoryService.userSRepository.getMyScheduliung(state.accessToken);
    //print("RESULTADO API: $userSMy");
    state = state.copyWith(userSMyList: userSMy); 
  } catch (e, stackTrace) {
    print("Error exacto: $e");
    print("Stacktrace: $stackTrace"); 
  }
}
  Future<void> deleteScheduling(int id) async {
    try {
      // 1. Llamar al repositorio/API para eliminar en el backend
      // Debes asegurarte de tener este método en tu UserSchudelingRepository
      await repositoryService.userSRepository.delete(id, state.accessToken);

      // 2. Actualizar el estado local filtrando el elemento eliminado
      state = state.copyWith(
        userS: state.userS.where((element) => element.id != id).toList(),
      );
      
      debugPrint("Agendamiento $id eliminado con éxito");
    } catch (e) {
      debugPrint("Error al eliminar: $e");
    }
  }
}