
import 'package:trainer_app/domain/models/exerciseModel.dart';
import 'package:trainer_app/global/exerciseApi.dart';


class ExerciseRepository {
  final ExerciseApi api;

  ExerciseRepository(this.api);

  Future<List<Exercise>> getAll() async {
    // Llamamos al endpoint definido en tu API
    final dynamic data = await api.get('/api/exercise/');

    // Manejamos si la API devuelve la lista directamente o dentro de un objeto 'data'
    final List<dynamic> list = (data is Map && data.containsKey('data')) 
        ? data['data'] 
        : data as List<dynamic>;

    return list.map((item) => Exercise.fromJson(item)).toList();
  }

  Future<Exercise> create(Exercise exercise, String token) async {
    final data = await api.post('/api/exercise/', exercise.toJson(), token);
    return Exercise.fromJson(data);
  }

  Future<Exercise> update(Exercise exercise, String token) async {
    // Aseguramos que el ID existe antes de la petición
    if (exercise.id == null) throw Exception('ID de ejercicio es necesario para actualizar');
    
    final data = await api.put('/api/exercise/${exercise.id}/', exercise.toJson(), token);
    return Exercise.fromJson(data);
  }

  /*Future<void> delete(int id, String token) async {
    // El método delete usualmente no devuelve cuerpo (204 No Content)
    await api.delete('/api/exercise/$id/', token);
  }*/
}