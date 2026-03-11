// To parse this JSON data, do
//
//     final objetive = objetiveFromJson(jsonString);

import 'dart:convert';

Objetive objetiveFromJson(String str) => Objetive.fromJson(json.decode(str));

String objetiveToJson(Objetive data) => json.encode(data.toJson());

class Objetive {
    List<ObjetiveDatum> data;

    Objetive({
        required this.data,
    });

    Objetive copyWith({
        List<ObjetiveDatum>? data,
    }) => 
        Objetive(
            data: data ?? this.data,
        );

    factory Objetive.fromJson(Map<String, dynamic> json) => Objetive(
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
