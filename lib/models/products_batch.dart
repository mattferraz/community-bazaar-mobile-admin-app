import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';

class ProductsBatch {
  int? id;
  String note;
  DateTime deliveryDate;
  SupervisoryOrgan supervisoryOrganDto;
  DoneeInstitution? doneeInstitutionDto;

  ProductsBatch({
    this.id,
    required this.note,
    required this.deliveryDate,
    required this.supervisoryOrganDto,
    required this.doneeInstitutionDto
  });

  factory ProductsBatch.fromJson(Map<String, dynamic> json) => ProductsBatch(
    id: json["id"],
    note: json["note"],
    deliveryDate: DateTime.parse(json["deliveryDate"]),
    supervisoryOrganDto: SupervisoryOrgan.fromJson(json["supervisoryOrganDTO"]),
    doneeInstitutionDto: DoneeInstitution.fromJson(json["doneeInstitutionDTO"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note": note,
    "deliveryDate": deliveryDate.toIso8601String(),
    "supervisoryOrganDTO": supervisoryOrganDto.toJson(),
    "doneeInstitutionDTO": doneeInstitutionDto?.toJson()
  };
}