
import 'package:trainer_app/domain/models/model.dart';
import 'openingScheduleModel.dart';

class UserSchedule {
     List<Datum> data;

    UserSchedule({
        required this.data,
    });

    UserSchedule copyWith({
        List<Datum>? data,
    }) => 
        UserSchedule(
            data: data ?? this.data,
        );

    factory UserSchedule.fromJson(Map<String, dynamic> json) => UserSchedule(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    DateTime scheduledDate;
    ExerciseObjetiveExercise exerciseObjetiveExercise;
    OpeningSchedule openingSchedule;
    UserShort user;

    Datum({
        required this.id,
        required this.name,
        required this.scheduledDate,
        required this.exerciseObjetiveExercise,
        required this.openingSchedule,
        required this.user,
    });

    Datum copyWith({
        int? id,
        String? name,
        DateTime? scheduledDate,
        ExerciseObjetiveExercise? exerciseObjetiveExercise,
        OpeningSchedule? openingSchedule,
        UserShort? user,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            scheduledDate: scheduledDate ?? this.scheduledDate,
            exerciseObjetiveExercise: exerciseObjetiveExercise ?? this.exerciseObjetiveExercise,
            openingSchedule: openingSchedule ?? this.openingSchedule,
            user: user ?? this.user,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    scheduledDate: DateTime.parse(json["scheduled_date"]),
    exerciseObjetiveExercise: ExerciseObjetiveExercise.fromJson(json["exercise_objetive_exercise"]),
    openingSchedule: OpeningSchedule.fromJson(json["opening_schedule"]),
    user: UserShort.fromJson(json["user"]),
);

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "scheduled_date": "${scheduledDate.year.toString().padLeft(4, '0')}-${scheduledDate.month.toString().padLeft(2, '0')}-${scheduledDate.day.toString().padLeft(2, '0')}",
        "exercise_objetive_exercise": exerciseObjetiveExercise.toJson(),
        "opening_schedule": openingSchedule.toJson(),
        "user": user.toString(),
    };
}
