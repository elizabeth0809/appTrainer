import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/userSchudelingApi.dart';

class UserSchudelingRepository {
  final UserSchudelingApi api;
  UserSchudelingRepository(this.api);

Future<List<Datum>> getAll(String token) async {
  final List<dynamic> data = await api.getAll(token);
  
  // Usamos .map((item) => Datum.fromJson(item as Map<String, dynamic>))
  return data.map((item) => Datum.fromJson(item as Map<String, dynamic>)).toList();
}
Future<void> delete(int id, String token) async {
  await api.delete(id, token);
}
}
