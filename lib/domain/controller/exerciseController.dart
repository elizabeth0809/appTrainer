import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:trainer_app/domain/provider/exerciseService.dart';
import 'package:trainer_app/global/http.dart';


class ExerciseController extends StateNotifier<ExerciseState> {
  final GetIt _getIt = GetIt.instance;
  late HttpService _httpService;
  ExerciseController(super._state){
    _httpService = _getIt.get<HttpService>();
    _setup();
  }
  Future<void> _setup() async{
    loadData();
  }
Future<void> loadData() async {
  try {
    final exercises = await _httpService.getExercises();

    print('Cantidad: ${exercises.length}');

    // aquí luego:
    state = state.copyWith(data: exercises);
  } catch (e) {
    print('Error al cargar: $e');
  }
}

}
