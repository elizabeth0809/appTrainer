// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

import 'package:trainer_app/domain/models/profileModel.dart';
import 'package:trainer_app/domain/models/userMeasurementModel.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    bool success;
    ProfileData data;

    UserData({
        required this.success,
        required this.data,
    });

    UserData copyWith({
        bool? success,
        ProfileData? data,
    }) => 
        UserData(
            success: success ?? this.success,
            data: data ?? this.data,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        success: json["success"],
        data: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class ProfileData {
    int id;
    String name;
    String email;
    String role;
    DateTime createdAt;
    DateTime updatedAt;
    Profile profile;
    UserMeasurement userMeasurement;

    ProfileData({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
        required this.profile,
        required this.userMeasurement,
    });

    ProfileData copyWith({
        int? id,
        String? name,
        String? email,
        String? role,
        DateTime? createdAt,
        DateTime? updatedAt,
        Profile? profile,
        UserMeasurement? userMeasurement,
    }) => 
        ProfileData(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            role: role ?? this.role,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            profile: profile ?? this.profile,
            userMeasurement: userMeasurement ?? this.userMeasurement,
        );

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profile: Profile.fromJson(json["profile"]),
        userMeasurement: UserMeasurement.fromJson(json["user_measurement"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profile": profile.toJson(),
        "user_measurement": userMeasurement.toJson(),
    };
}