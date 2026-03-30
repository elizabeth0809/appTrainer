// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) => UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
    String accessToken;
    RegisterData data;

    UserRegister({
        required this.accessToken,
        required this.data,
    });

    UserRegister copyWith({
        String? accessToken,
        RegisterData? data,
    }) => 
        UserRegister(
            accessToken: accessToken ?? this.accessToken,
            data: data ?? this.data,
        );

    factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        accessToken: json["access_token"],
        data: RegisterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "data": data.toJson(),
    };
}

class RegisterData {
    String name;
    String email;
    String role;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    RegisterData({
        required this.name,
        required this.email,
        required this.role,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    RegisterData copyWith({
        String? name,
        String? email,
        String? role,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        RegisterData(
            name: name ?? this.name,
            email: email ?? this.email,
            role: role ?? this.role,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        name: json["name"],
        email: json["email"],
        role: json["role"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
