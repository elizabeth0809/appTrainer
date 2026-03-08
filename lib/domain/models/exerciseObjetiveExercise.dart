import 'package:trainer_app/domain/models/exerciseModel.dart';
import 'package:trainer_app/domain/models/objetiveExerciseModel.dart';

class ExerciseObjetiveExercise {
    int id;
    Exercise exercise;
    ObjetiveExercise objetiveExercise;

    ExerciseObjetiveExercise({
        required this.id,
        required this.exercise,
        required this.objetiveExercise,
    });

    factory ExerciseObjetiveExercise.fromJson(Map<String, dynamic> json) => ExerciseObjetiveExercise(
        id: json["id"],
        exercise: Exercise.fromJson(json["exercise"]),
        objetiveExercise: ObjetiveExercise.fromJson(json["objetive_exercise"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "exercise": exercise.toJson(),
        "objetive_exercise": objetiveExercise.toString(),
    };
}