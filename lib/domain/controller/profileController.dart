import 'package:hooks_riverpod/legacy.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/provider/loginProvider.dart';
import 'package:trainer_app/domain/repositories/profileRepository.dart';

class ProfileState {
  final Profile? profile;
  final List<UserMeasurement> measurements;
  final bool isLoading;

  ProfileState({this.profile, this.measurements = const [], this.isLoading = false});

  ProfileState copyWith({Profile? profile, List<UserMeasurement>? measurements, bool? isLoading}) {
    return ProfileState(
      profile: profile ?? this.profile,
      measurements: measurements ?? this.measurements,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository repo;
  final String token;

  ProfileNotifier(this.repo, this.token) : super(ProfileState()) {
    loadAll();
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true);
    try {
      final profile = await repo.fetchProfile(token);
      final measurements = await repo.fetchMeasurements(token);
      state = state.copyWith(profile: profile, measurements: measurements, isLoading: false);
    } catch (e) {
      print("Error cargando perfil: $e");
      state = state.copyWith(isLoading: false);
    }
  }
  // En ProfileController.dart - agrega este método en ProfileNotifier

Future<void> updateMeasurement(int id, Map<String, dynamic> data) async {
  state = state.copyWith(isLoading: true);
  try {
    await repo.updateMeasurement(id, data, token);
    // Recargar todas las medidas después de la actualización
    final updatedMeasurements = await repo.fetchMeasurements(token);
    state = state.copyWith(
      measurements: updatedMeasurements,
      isLoading: false
    );
  } catch (e) {
    print("Error actualizando measurement: $e");
    state = state.copyWith(isLoading: false);
    rethrow; // Para manejar el error en la UI
  }
}

// O si prefieres una versión que solo actualice la medida específica sin recargar todas:
Future<void> updateMeasurementLocally(int id, Map<String, dynamic> data) async {
  state = state.copyWith(isLoading: true);
  try {
    await repo.updateMeasurement(id, data, token);
    
    // Actualizar solo la medida modificada en la lista existente
    final updatedMeasurements = state.measurements.map((m) {
      if (m.id == id) {
        return UserMeasurement.fromJson({
          ...m.toJson(),
          ...data,
        });
      }
      return m;
    }).toList();
    
    state = state.copyWith(
      measurements: updatedMeasurements,
      isLoading: false
    );
  } catch (e) {
    print("Error actualizando measurement: $e");
    state = state.copyWith(isLoading: false);
    rethrow;
  }
}
}

final profileControllerProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  final token = ref.watch(loginProvider).user?.accessToken ?? '';
  return ProfileNotifier(repo, token);
});