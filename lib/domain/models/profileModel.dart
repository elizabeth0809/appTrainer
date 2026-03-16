
class Profile {
    int id;
    String phone;
    DateTime birthdate;

    Profile({
        required this.id,
        required this.phone,
        required this.birthdate,
    });

    Profile copyWith({
        int? id,
        String? phone,
        DateTime? birthdate,
    }) => 
        Profile(
            id: id ?? this.id,
            phone: phone ?? this.phone,
            birthdate: birthdate ?? this.birthdate,
        );

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        phone: json["phone"],
        birthdate: DateTime.parse(json["birthdate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    };
}
