import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:trainer_app/domain/service/exerciseService.dart';
import 'package:trainer_app/global/http.dart';

import '../models/exerciseModel.dart';

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
  if (state.data == null) {
    try {
  final List<Exercise> exercises = await _httpService.getExercises();
      
    print(exercises.length); 
      print(exercises.first.name);
   } catch (e) {
      print('Error al cargar: $e');
    }
  }
}

}
