import '../models/model.dart';

class ExerciseState {
  Exercise? data;

  ExerciseState({
    required this.data
  });
  ExerciseState.initial() : data =null;
  ExerciseState copyWith({Exercise? data}){
    return ExerciseState(data: data ?? this.data);
  }
}