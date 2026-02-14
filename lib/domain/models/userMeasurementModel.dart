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
    DateTime createdAt;
    DateTime updatedAt;
    int userId;

    UserMeasurement({
        required this.id,
        required this.weight,
        required this.age,
        required this.height,
        required this.gender,
        required this.level,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
    });

    UserMeasurement copyWith({
        int? id,
        int? weight,
        int? age,
        int? height,
        String? gender,
        String? level,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? userId,
    }) => 
        UserMeasurement(
            id: id ?? this.id,
            weight: weight ?? this.weight,
            age: age ?? this.age,
            height: height ?? this.height,
            gender: gender ?? this.gender,
            level: level ?? this.level,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            userId: userId ?? this.userId,
        );

    factory UserMeasurement.fromJson(Map<String, dynamic> json) => UserMeasurement(
        id: json["id"],
        weight: json["weight"],
        age: json["age"],
        height: json["height"],
        gender: json["gender"],
        level: json["level"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "age": age,
        "height": height,
        "gender": gender,
        "level": level,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
    };
}
