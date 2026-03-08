class Exercise {
  int? id;
  String name;
  int price;
  String img;
  String modalities;

  Exercise({
    this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.modalities,
  });

  Exercise copyWith({
    int? id,
    String? name,
    int? price,
    String? img,
    String? modalities,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      img: img ?? this.img,
      modalities: modalities ?? this.modalities,
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        img: json["img"],
        modalities: json["modalities"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "modalities": modalities
      };
}