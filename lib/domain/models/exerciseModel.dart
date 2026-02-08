// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

List<Exercise> exerciseFromJson(String str) => List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

String exerciseToJson(List<Exercise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exercise {
    int id;
    String name;
    int price;
    String img;
    String modalities;
    DateTime createdAt;
    DateTime updatedAt;

    Exercise({
        required this.id,
        required this.name,
        required this.price,
        required this.img,
        required this.modalities,
        required this.createdAt,
        required this.updatedAt,
    });

    Exercise copyWith({
        int? id,
        String? name,
        int? price,
        String? img,
        String? modalities,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Exercise(
            id: id ?? this.id,
            name: name ?? this.name,
            price: price ?? this.price,
            img: img ?? this.img,
            modalities: modalities ?? this.modalities,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        img: json["img"],
        modalities: json["modalities"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "modalities": modalities,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
