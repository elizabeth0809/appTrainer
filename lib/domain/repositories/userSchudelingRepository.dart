import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/userSchudelingApi.dart';

class UserSchudelingRepository {
  final UserSchudelingApi api;
  UserSchudelingRepository(this.api);

  Future<List<UserScheduling>> getAll(String token) async {
    final List<dynamic> data = await api.getAll(token);
    
    // Convertimos la lista de mapas en una lista de objetos de modelo
    return data.map((item) => UserScheduling.fromJson(item)).toList();
  }
}
