// To parse this JSON data, do
//
//     final userMeasurement = userMeasurementFromJson(jsonString);

import 'dart:convert';

List<UserMeasurement> userMeasurementFromJson(String str) => List<UserMeasurement>.from(json.decode(str).map((x) => UserMeasurement.fromJson(x)));

String userMeasurementToJson(List<UserMeasurement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserMeasurement {
    int id;
    int weight;
    int age;
    int height;
    String gender;
    String level;

    UserMeasurement({
        required this.id,
        required this.weight,
        required this.age,
        required this.height,
        required this.gender,
        required this.level,
    });

    UserMeasurement copyWith({
        int? id,
        int? weight,
        int? age,
        int? height,
        String? gender,
        String? level,
    }) => 
        UserMeasurement(
            id: id ?? this.id,
            weight: weight ?? this.weight,
            age: age ?? this.age,
            height: height ?? this.height,
            gender: gender ?? this.gender,
            level: level ?? this.level,
        );

    factory UserMeasurement.fromJson(Map<String, dynamic> json) => UserMeasurement(
        id: json["id"],
        weight: json["weight"],
        age: json["age"],
        height: json["height"],
        gender: json["gender"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "age": age,
        "height": height,
        "gender": gender,
        "level": level,
    };
}
