class UserRegister {
  final int id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;

  UserRegister({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
