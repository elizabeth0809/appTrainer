// To parse this JSON data, do
//
//     final openingSchedule = openingScheduleFromJson(jsonString);

import 'dart:convert';

List<OpeningSchedule> openingScheduleFromJson(String str) => List<OpeningSchedule>.from(json.decode(str).map((x) => OpeningSchedule.fromJson(x)));

String openingScheduleToJson(List<OpeningSchedule> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpeningSchedule {
    int id;
    String name;
    String day;
    String startTime;
    String endtime;
    DateTime createdAt;
    DateTime updatedAt;

    OpeningSchedule({
        required this.id,
        required this.name,
        required this.day,
        required this.startTime,
        required this.endtime,
        required this.createdAt,
        required this.updatedAt,
    });

    OpeningSchedule copyWith({
        int? id,
        String? name,
        String? day,
        String? startTime,
        String? endtime,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        OpeningSchedule(
            id: id ?? this.id,
            name: name ?? this.name,
            day: day ?? this.day,
            startTime: startTime ?? this.startTime,
            endtime: endtime ?? this.endtime,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory OpeningSchedule.fromJson(Map<String, dynamic> json) => OpeningSchedule(
        id: json["id"],
        name: json["name"],
        day: json["day"],
        startTime: json["start_time"],
        endtime: json["endtime"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "day": day,
        "start_time": startTime,
        "endtime": endtime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
