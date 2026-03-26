import 'dart:convert';
import 'package:trainer_app/domain/models/exerciseObjetiveExercise.dart';
import 'package:trainer_app/domain/models/openingScheduleModel.dart';

MyScheduling mySchedulingFromJson(String str) => MyScheduling.fromJson(json.decode(str));

String mySchedulingToJson(MyScheduling data) => json.encode(data.toJson());

class MyScheduling {
    List<MySchedulingDatum> data;

    MyScheduling({
        required this.data,
    });

    MyScheduling copyWith({
        List<MySchedulingDatum>? data,
    }) => 
        MyScheduling(
            data: data ?? this.data,
        );

    factory MyScheduling.fromJson(Map<String, dynamic> json) => MyScheduling(
        data: List<MySchedulingDatum>.from(json["data"].map((x) => MySchedulingDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MySchedulingDatum {
    int id;
    String name;
    DateTime scheduledDate;
    ExerciseObjetiveExercise exerciseObjetiveExercise;
    OpeningSchedule openingSchedule;

    MySchedulingDatum({
        required this.id,
        required this.name,
        required this.scheduledDate,
        required this.exerciseObjetiveExercise,
        required this.openingSchedule,
    });

    MySchedulingDatum copyWith({
        int? id,
        String? name,
        DateTime? scheduledDate,
        ExerciseObjetiveExercise? exerciseObjetiveExercise,
        OpeningSchedule? openingSchedule,
    }) => 
        MySchedulingDatum(
            id: id ?? this.id,
            name: name ?? this.name,
            scheduledDate: scheduledDate ?? this.scheduledDate,
            exerciseObjetiveExercise: exerciseObjetiveExercise ?? this.exerciseObjetiveExercise,
            openingSchedule: openingSchedule ?? this.openingSchedule,
        );

    factory MySchedulingDatum.fromJson(Map<String, dynamic> json) => MySchedulingDatum(
        id: json["id"],
        name: json["name"],
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        exerciseObjetiveExercise: ExerciseObjetiveExercise.fromJson(json["exercise_objetive_exercise"]),
        openingSchedule: OpeningSchedule.fromJson(json["opening_schedule"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "scheduled_date": "${scheduledDate.year.toString().padLeft(4, '0')}-${scheduledDate.month.toString().padLeft(2, '0')}-${scheduledDate.day.toString().padLeft(2, '0')}",
        "exercise_objetive_exercise": exerciseObjetiveExercise.toJson(),
        "opening_schedule": openingSchedule.toJson(),
    };
}
