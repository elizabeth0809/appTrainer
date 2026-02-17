import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:trainer_app/domain/provider/exerciseProvider.dart';
import 'package:trainer_app/global/exerciseApi.dart';

/*class ExerciseController extends StateNotifier<ExerciseState> {
  final ExerciseApi _httpService;

  ExerciseController(this._httpService)
      : super(ExerciseState.initial()) {
    loadData();
  }

  Future<void> loadData() async {
    try {
      state = state.copyWith(isLoading: true);

      final exercises = await _httpService.getExercises();

      state = state.copyWith(
        data: exercises,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Error al cargar: $e');
    }
  }
}*/
