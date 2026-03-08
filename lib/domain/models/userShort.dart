class UserShort {
  int id;
  String name;
  String email;

  UserShort({required this.id, required this.name, required this.email});

  factory UserShort.fromJson(Map<String, dynamic> json) => UserShort(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
      );
}