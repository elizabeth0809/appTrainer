class ObjetiveExercise {
    int id;
    String name;

    ObjetiveExercise({required this.id, required this.name});

    factory ObjetiveExercise.fromJson(Map<String, dynamic> json) => ObjetiveExercise(
        id: json["id"] ?? 0,
        name: json["name"] ?? "Sin nombre",
    );
}