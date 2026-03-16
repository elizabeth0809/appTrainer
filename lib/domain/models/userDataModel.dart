// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

import 'package:trainer_app/domain/models/profileModel.dart';
import 'package:trainer_app/domain/models/userMeasurementModel.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    List<UserDataDatum> data;

    UserData({
        required this.data,
    });

    UserData copyWith({
        List<UserDataDatum>? data,
    }) => 
        UserData(
            data: data ?? this.data,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        data: List<UserDataDatum>.from(json["data"].map((x) => UserDataDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class UserDataDatum {
    int id;
    String name;
    String email;
    UserMeasurement userMeasurement;
    Profile profile;

    UserDataDatum({
        required this.id,
        required this.name,
        required this.email,
        required this.userMeasurement,
        required this.profile,
    });

    UserDataDatum copyWith({
        int? id,
        String? name,
        String? email,
        UserMeasurement? userMeasurement,
        Profile? profile,
    }) => 
        UserDataDatum(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            userMeasurement: userMeasurement ?? this.userMeasurement,
            profile: profile ?? this.profile,
        );

    factory UserDataDatum.fromJson(Map<String, dynamic> json) => UserDataDatum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userMeasurement: UserMeasurement.fromJson(json["user_measurement"]),
        profile: Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "user_measurement": userMeasurement.toJson(),
        "profile": profile.toJson(),
    };
}
