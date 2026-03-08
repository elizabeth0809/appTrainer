// To parse this JSON data, do
//
//     final exerciseObjetiveExercise = exerciseObjetiveExerciseFromJson(jsonString);

import 'dart:convert';

import 'package:trainer_app/domain/models/exerciseModel.dart';
import 'package:trainer_app/domain/models/objetiveExerciseModel.dart';

ExerciseObjetiveExercise exerciseObjetiveExerciseFromJson(String str) => ExerciseObjetiveExercise.fromJson(json.decode(str));

String exerciseObjetiveExerciseToJson(ExerciseObjetiveExercise data) => json.encode(data.toJson());

class ExerciseObjetiveExercise {
    List<ExerciseObjetiveExerciseDatum> data;

    ExerciseObjetiveExercise({
        required this.data,
    });

    ExerciseObjetiveExercise copyWith({
        List<ExerciseObjetiveExerciseDatum>? data,
    }) => 
        ExerciseObjetiveExercise(
            data: data ?? this.data,
        );

    factory ExerciseObjetiveExercise.fromJson(Map<String, dynamic> json) => ExerciseObjetiveExercise(
        data: List<ExerciseObjetiveExerciseDatum>.from(json["data"].map((x) => ExerciseObjetiveExerciseDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ExerciseObjetiveExerciseDatum {
    int id;
    Exercise exercise;
    ObjetiveExercise objetiveExercise;

    ExerciseObjetiveExerciseDatum({
        required this.id,
        required this.exercise,
        required this.objetiveExercise,
    });

    ExerciseObjetiveExerciseDatum copyWith({
        int? id,
        Exercise? exercise,
        ObjetiveExercise? objetiveExercise,
    }) => 
        ExerciseObjetiveExerciseDatum(
            id: id ?? this.id,
            exercise: exercise ?? this.exercise,
            objetiveExercise: objetiveExercise ?? this.objetiveExercise,
        );

    factory ExerciseObjetiveExerciseDatum.fromJson(Map<String, dynamic> json) => ExerciseObjetiveExerciseDatum(
        id: json["id"],
        exercise: Exercise.fromJson(json["exercise"]),
        objetiveExercise: ObjetiveExercise.fromJson(json["objetive_exercise"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "exercise": exercise.toJson(),
        "objetive_exercise": objetiveExercise.toJson(),
    };
}

