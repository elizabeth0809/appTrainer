import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/profileApi.dart';

class ProfileRepository {
  final ProfileApi api;
  ProfileRepository(this.api);

  Future<Profile> fetchProfile(String token) async {
  final dynamic data = await api.getProfile(token);
  
  // Lógica para extraer el perfil si viene como mapa o como primer elemento de una lista
  Map<String, dynamic> profileMap;
  
  if (data is List) {
    profileMap = data.first as Map<String, dynamic>;
  } else if (data is Map && data.containsKey('data')) {
    profileMap = data['data'] as Map<String, dynamic>;
  } else {
    profileMap = data as Map<String, dynamic>;
  }

  return Profile.fromJson(profileMap);
  }

  Future<List<UserMeasurement>> fetchMeasurements(String token) async {
    final list = await api.getMeasurements(token);
    return list.map((item) => UserMeasurement.fromJson(item)).toList();
  }
  Future<void> updateMeasurement(int id, Map<String, dynamic> data, String token) async {
  await api.updateMeasurement(id, data, token);
}

// Opcionalmente, podrías agregar un método para actualizar y recargar
Future<UserMeasurement> updateAndGetMeasurement(int id, Map<String, dynamic> data, String token) async {
  await api.updateMeasurement(id, data, token);
  // Después de actualizar, podrías recargar todas las medidas
  final measurements = await fetchMeasurements(token);
  // Buscar la medida actualizada
  return measurements.firstWhere((m) => m.id == id);
}
}

// Provider del Repositorio
final profileRepositoryProvider = Provider((ref) => ProfileRepository(ProfileApi()));