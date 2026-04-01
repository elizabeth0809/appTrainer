import 'package:hooks_riverpod/legacy.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/provider/provider.dart';
import 'package:trainer_app/domain/repositories/repository.dart';


class ProfileState {
  final ProfileData? profile;
  final UserMeasurement? measurements;
  final bool isLoading;

  ProfileState({
    this.profile,
    this.measurements,
    this.isLoading = false,
  });

  ProfileState copyWith({
    ProfileData? profile,
    UserMeasurement? measurements,
    bool? isLoading,
  }) {
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
  final int userId;

  ProfileNotifier(this.repo, this.token, this.userId) : super(ProfileState()) {
    loadAll();
  }
 Future<void> loadAll() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final response = await repo.getProfile(token);
      if (!mounted) return; 

      state = state.copyWith(
        profile: response.data,
        measurements: response.data.userMeasurement,
        isLoading: false,
      );
    } catch (e) {
      print("Error cargando perfil: $e");
      if (!mounted) return;

      state = state.copyWith(isLoading: false);
    }
  }
Future<void> createProfile(Map<String, dynamic> data) async {
  state = state.copyWith(isLoading: true);
  try {
    await repo.createProfile(data, token);
    await loadAll(); 
  } catch (e) {
    print("Error en createProfile: $e");
    state = state.copyWith(isLoading: false);
    rethrow; 
  }
}
Future<void> updateProfile(Map<String, dynamic> data) async {
  state = state.copyWith(isLoading: true);
  try {
    await repo.updateProfile(data, token);
    await loadAll(); 
  } catch (e) {
    print("Error en updateProfile: $e");
    state = state.copyWith(isLoading: false);
    rethrow; 
  }
}

Future<void> updateMeasurementProfile(Map<String, dynamic> data) async {
  state = state.copyWith(isLoading: true);
  try {
    await repo.updateMeasurementProfile(data, token);
    await loadAll(); 
    
  } catch (e) {
    print("Error actualizando: $e");
    state = state.copyWith(isLoading: false);
    rethrow;
  }
}
Future<void> createMeasurementProfile(Map<String, dynamic> data) async {
  state = state.copyWith(isLoading: true);
  try {
    await repo.createMeasurementProfile(data, token);
    await loadAll(); 
    
  } catch (e) {
    print("Error actualizando: $e");
    state = state.copyWith(isLoading: false);
    rethrow;
  }
}
}

final profileControllerProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repo = ref.watch(profileRepositoryProvider);

  final loginState = ref.watch(loginProvider);
  final token = loginState.user?.accessToken ?? '';
  final userId = loginState.user?.data.id ?? 0;

  return ProfileNotifier(repo, token, userId);
});