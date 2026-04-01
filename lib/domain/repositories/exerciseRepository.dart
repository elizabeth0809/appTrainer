import 'package:trainer_app/domain/models/exerciseModel.dart';
import 'package:trainer_app/global/exerciseApi.dart';

class ExerciseRepository {
  final ExerciseApi api;

  ExerciseRepository(this.api);

  // Nota: Si tu baseUrl ya termina en /api, el endpoint debe empezar con /
  // Resultado: http://.../api/exercise/
  
  Future<List<Exercise>> getAll() async {
    final dynamic data = await api.get('/exercise/');
    
    List<dynamic> list;
    if (data is Map && data.containsKey('data')) {
      list = data['data'];
    } else if (data is List) {
      list = data;
    } else {
      return [];
    }

    return list.map((item) => Exercise.fromJson(item)).toList();
  }

  Future<Exercise> create(Exercise exercise, String token) async {
    final data = await api.post('/exercise/', exercise.toJson(), token);
    return Exercise.fromJson(data);
  }

  Future<Exercise> update(Exercise exercise, String token) async {
    if (exercise.id == null) {
      throw Exception('ID de ejercicio es necesario para actualizar');
    }
    final data = await api.put('/exercise/${exercise.id}/', exercise.toJson(), token);
    return Exercise.fromJson(data);
  }

  Future<void> delete(int id, String token) async {
    await api.delete('/exercise/$id/', token);
  }
}