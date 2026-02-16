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

    OpeningSchedule({
        required this.id,
        required this.name,
        required this.day,
        required this.startTime,
        required this.endtime,
    });

    OpeningSchedule copyWith({
        int? id,
        String? name,
        String? day,
        String? startTime,
        String? endtime,
    }) => 
        OpeningSchedule(
            id: id ?? this.id,
            name: name ?? this.name,
            day: day ?? this.day,
            startTime: startTime ?? this.startTime,
            endtime: endtime ?? this.endtime,
        );

    factory OpeningSchedule.fromJson(Map<String, dynamic> json) => OpeningSchedule(
    id: json["id"],
    name: json["name"],
    day: json["day"],
    startTime: json["start_time"],
    // CAMBIO: Quita el guion bajo para que coincida con el backend ("endtime")
    endtime: json["endtime"], 
);

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "day": day,
        "start_time": startTime,
        "end_time": endtime,
    };
}
