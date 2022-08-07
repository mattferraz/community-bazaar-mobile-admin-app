import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:flutter/material.dart';

class BusinessHour {
  int? id;
  int weekday;
  TimeOfDay openTime;
  TimeOfDay closeTime;
  DoneeInstitution doneeInstitution;

  BusinessHour({
    this.id,
    required this.weekday,
    required this.openTime,
    required this.closeTime,
    required this.doneeInstitution
  });

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    id: json["id"],
    weekday: json["weekday"], 
    openTime: json["openTime"], 
    closeTime: json["closeTime"], 
    doneeInstitution: DoneeInstitution.fromJson(json["doneeInstitution"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekday": weekday,
    "openTime": openTime,
    "closeTime": closeTime,
    "doneeInstitution": doneeInstitution.toJson()
  };
}