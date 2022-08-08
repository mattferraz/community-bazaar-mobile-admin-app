import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/utils/date_time_formatter.dart';
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
    openTime: DateTimeFormatter.jsonToTime(json["openTime"]), 
    closeTime: DateTimeFormatter.jsonToTime(json["closeTime"]), 
    doneeInstitution: DoneeInstitution.fromJson(json["doneeInstitutionDto"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekday": weekday,
    "openTime": DateTimeFormatter.timeToJson(openTime),
    "closeTime": DateTimeFormatter.timeToJson(closeTime),
    "doneeInstitutionDto": doneeInstitution.toJson()
  };
}