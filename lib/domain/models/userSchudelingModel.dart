import 'dart:convert';
import 'exerciseModel.dart';
import 'userModel.dart';
import 'openingScheduleModel.dart';
import 'userMeasurementModel.dart';

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
    int repetitions;
    String startTime;
    String endTime;
    Exercise exercise;
    UserMeasurement userMeasurement;
    OpeningSchedule openingSchedule;
    User user;

    Datum({
        required this.id,
        required this.name,
        required this.repetitions,
        required this.startTime,
        required this.endTime,
        required this.exercise,
        required this.userMeasurement,
        required this.openingSchedule,
        required this.user,
    });

    Datum copyWith({
        int? id,
        String? name,
        int? repetitions,
        String? startTime,
        String? endTime,
        Exercise? exercise,
        UserMeasurement? userMeasurement,
        OpeningSchedule? openingSchedule,
        User? user,
    }) => 
        Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            repetitions: repetitions ?? this.repetitions,
            startTime: startTime ?? this.startTime,
            endTime: endTime ?? this.endTime,
            exercise: exercise ?? this.exercise,
            userMeasurement: userMeasurement ?? this.userMeasurement,
            openingSchedule: openingSchedule ?? this.openingSchedule,
            user: user ?? this.user,
        );

   factory Datum.fromJson(Map<String, dynamic> json) {
  try {
   return Datum(
    id: json["id"],
    name: json["name"],
    repetitions: json["repetitions"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    exercise: Exercise.fromJson(json["exercise"]),
    userMeasurement: UserMeasurement.fromJson(json["user_measurement"]),
    openingSchedule: OpeningSchedule.fromJson(json["opening_schedule"]),
    user: User(
      accessToken: "", // Valor vacío ya que el listado no trae el token
      data: Data.fromJson(json["user"]) 
    ));
  } catch (e) {
    print("EL ERROR ESTÁ AQUÍ: $e");
    rethrow;
  }
}


    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "repetitions": repetitions,
        "start_time": startTime,
        "end_time": endTime,
        "exercise": exercise.toJson(),
        "user_measurement": userMeasurement.toJson(),
        "opening_schedule": openingSchedule.toJson(),
        "user": user.toJson(),
    };
}
