import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/profileApi.dart';

class ProfileRepository {
  final ProfileApi api;
  ProfileRepository(this.api);
Future<UserData> getProfile(String token) async {
  return await api.getProfile(token);
}
Future<void> createProfile(Map<String, dynamic> data, String token) async {
  await api.createProfile(data, token);
}
Future<void> updateProfile(Map<String, dynamic> data, String token) async {
  await api.updateProfileData(data, token);
}
Future<void> createMeasurementProfile(Map<String, dynamic> data, String token) async {
  await api.createMeasurement(data, token);
}
Future<void> updateMeasurementProfile(Map<String, dynamic> data, String token) async {
  await api.updateMeasurementProfile(data, token);
}
}
final profileRepositoryProvider = Provider((ref) => ProfileRepository(ProfileApi()));