import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';

class ProductsBatch {
  int? id;
  String note;
  DateTime deliveryDate;
  SupervisoryOrgan supervisoryOrgan;
  DoneeInstitution? doneeInstitution;

  ProductsBatch({
    this.id,
    required this.note,
    required this.deliveryDate,
    required this.supervisoryOrgan,
    required this.doneeInstitution
  });

  factory ProductsBatch.fromJson(Map<String, dynamic> json) => ProductsBatch(
    id: json["id"],
    note: json["note"],
    deliveryDate: json["deliveryDate"],
    supervisoryOrgan: SupervisoryOrgan.fromJson(json["supervisoryOrgan"]),
    doneeInstitution: DoneeInstitution.fromJson(json["doneeInstitution"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note": note,
    "dateTime": deliveryDate.toLocal(),
    "supervisoryOrgan": supervisoryOrgan.toJson(),
    "doneeInstitution": doneeInstitution?.toJson()
  };
}