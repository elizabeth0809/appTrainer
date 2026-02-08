// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String accessToken;
    Data data;

    User({
        required this.accessToken,
        required this.data,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        accessToken: json["access_token"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    String role;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
