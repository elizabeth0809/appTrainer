import 'package:trainer_app/domain/models/exerciseModel.dart';

class ObjetiveExercise {
    int id;
    String name;
    Exercise exercise;

    ObjetiveExercise({
        required this.id,
        required this.name,
        required this.exercise,
    });

    ObjetiveExercise copyWith({
        int? id,
        String? name,
        Exercise? exercise,
    }) => 
        ObjetiveExercise(
            id: id ?? this.id,
            name: name ?? this.name,
            exercise: exercise ?? this.exercise,
        );

    factory ObjetiveExercise.fromJson(Map<String, dynamic> json) => ObjetiveExercise(
        id: json["id"],
        name: json["name"],
        exercise: Exercise.fromJson(json["exercise"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "exercise": exercise.toJson(),
    };
}