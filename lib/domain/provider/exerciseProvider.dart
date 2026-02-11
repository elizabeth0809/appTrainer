import '../models/model.dart';
class ExerciseState {
  final List<Exercise>? data;
  final bool isLoading;

  ExerciseState({this.data, this.isLoading = false});

  factory ExerciseState.initial() => ExerciseState(data: null, isLoading: false);

  ExerciseState copyWith({List<Exercise>? data, bool? isLoading}) {
    return ExerciseState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}