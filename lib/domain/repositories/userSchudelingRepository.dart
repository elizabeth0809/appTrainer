import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/userSchudelingApi.dart';

class UserSchudelingRepository {
  final UserSchudelingApi api;
  UserSchudelingRepository(this.api);

Future<Datum> create(Map<String, dynamic> schedulingData, String token) async {
  final responseData = await api.create(schedulingData, token);
  return Datum.fromJson(responseData['data']);
}
Future<List<Datum>> getAll(String token) async {
  final List<dynamic> data = await api.getAll(token);
  return data.map((item) => Datum.fromJson(item as Map<String, dynamic>)).toList();
}
Future<List<MySchedulingDatum>> getMyScheduliung(String token) async {
  final List<dynamic> data = await api.getMyScheduliung(token);
  return data.map((item) => MySchedulingDatum.fromJson(item as Map<String, dynamic>)).toList();
}
Future<void> delete(int id, String token) async {
  await api.delete(id, token);
}
}
