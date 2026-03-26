import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/objetiveExerciseApi.dart';

class ObjetiveExerciseRepository {
  final ObjetiveExerciseApi apiObjetiveExercise;

  ObjetiveExerciseRepository(this.apiObjetiveExercise);

  Future<List<ObjetiveDatum>> getAllObjetiveExercise(String token) async {
  final List<dynamic> ObjetiveExercisedata = await apiObjetiveExercise.getAllObjetiveExercise(token);
  return ObjetiveExercisedata.map((item) => ObjetiveDatum.fromJson(item as Map<String, dynamic>)).toList();
}
}