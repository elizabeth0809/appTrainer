// To parse this JSON data, do
//
//     final objetiveExercise = objetiveExerciseFromJson(jsonString);

import 'dart:convert';

ObjetiveExercise objetiveExerciseFromJson(String str) => ObjetiveExercise.fromJson(json.decode(str));

String objetiveExerciseToJson(ObjetiveExercise data) => json.encode(data.toJson());

class ObjetiveExercise {
    List<ObjetiveDatum> data;

    ObjetiveExercise({
        required this.data,
    });

    ObjetiveExercise copyWith({
        List<ObjetiveDatum>? data,
    }) => 
        ObjetiveExercise(
            data: data ?? this.data,
        );

    factory ObjetiveExercise.fromJson(Map<String, dynamic> json) => ObjetiveExercise(
        data: List<ObjetiveDatum>.from(json["data"].map((x) => ObjetiveDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ObjetiveDatum {
    int id;
    String name;

    ObjetiveDatum({
        required this.id,
        required this.name,
    });

    ObjetiveDatum copyWith({
        int? id,
        String? name,
    }) => 
        ObjetiveDatum(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory ObjetiveDatum.fromJson(Map<String, dynamic> json) => ObjetiveDatum(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
