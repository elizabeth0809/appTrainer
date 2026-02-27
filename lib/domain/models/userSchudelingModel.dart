import 'dart:convert';
import 'package:trainer_app/domain/models/model.dart';

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
    DateTime scheduledDate;
    ObjetiveExercise objetiveExercise;
    UserMeasurement userMeasurement;
    OpeningSchedule openingSchedule;
    User user;

    Datum({
        required this.id,
        required this.name,
        required this.scheduledDate,
        required this.objetiveExercise,
        required this.userMeasurement,
        required this.openingSchedule,
        required this.user,
    });

    Datum copyWith({
         int? id,
        String? name,
        DateTime? scheduledDate,
        ObjetiveExercise? objetiveExercise,
        UserMeasurement? userMeasurement,
        OpeningSchedule? openingSchedule,
        User? user,
    }) => 
           Datum(
            id: id ?? this.id,
            name: name ?? this.name,
            scheduledDate: scheduledDate ?? this.scheduledDate,
            objetiveExercise: objetiveExercise ?? this.objetiveExercise,
            userMeasurement: userMeasurement ?? this.userMeasurement,
            openingSchedule: openingSchedule ?? this.openingSchedule,
            user: user ?? this.user,
        );

   factory Datum.fromJson(Map<String, dynamic> json) {
  try {
   return Datum(
    id: json["id"],
    name: json["name"],
    scheduledDate: DateTime.parse(json["scheduled_date"]),
    objetiveExercise: ObjetiveExercise.fromJson(json["objetive_exercise"]),            
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
        "scheduled_date": "${scheduledDate.year.toString().padLeft(4, '0')}-${scheduledDate.month.toString().padLeft(2, '0')}-${scheduledDate.day.toString().padLeft(2, '0')}",
        "objetive_exercise": objetiveExercise.toJson(),
        "user_measurement": userMeasurement.toJson(),
        "opening_schedule": openingSchedule.toJson(),
        "user": user.toJson(),
    };
}
