class DoneeInstitution {
  int? id;
  String name;
  String address;
  String phoneNumber;
  String description;

  DoneeInstitution({
    this.id,
    required this.name,
    required this.address,
    required this.phoneNumber, 
    required this.description
  });

  factory DoneeInstitution.fromJson(Map<String, dynamic> json) => DoneeInstitution(
    id: json["id"],
    name: json["name"], 
    address: json["address"], 
    phoneNumber: json["phoneNumber"], 
    description: json["description"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name, 
    "address": address,
    "phoneNumber": phoneNumber,
    "description": description
  };
}
  