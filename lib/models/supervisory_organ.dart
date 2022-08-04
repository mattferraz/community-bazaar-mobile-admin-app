class SupervisoryOrgan {
    int? id;
    String name;
    String description;

  SupervisoryOrgan({
    this.id, 
    required this.name, 
    required this.description
  });

  factory SupervisoryOrgan.fromJson(Map<String, dynamic> json) => SupervisoryOrgan(
    id: int.tryParse(json["id"]),
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description
  };
}