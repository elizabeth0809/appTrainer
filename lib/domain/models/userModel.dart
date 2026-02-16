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
    String role;
    Data({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
    });

   factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    role: json["role"] ?? "customer",
);

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
    };
    
}
