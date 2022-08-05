import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bazaar_adm/constants/api_constants.dart';
import '../models/donee_institution.dart';

class DoneeInstitutionRepository {

  Future<List<DoneeInstitution>> findAllDoneeInstitutions() async {
    final http.Response response = await http.get(
      Uri.parse(ApiConstants.doneeInstitutionsUrl),
      headers: ApiConstants.headers
    );
    final Iterable<Map<String, dynamic>> decodedBody = json.decode(utf8.decode(response.bodyBytes));
    final List<DoneeInstitution> doneeInstitutions = List<DoneeInstitution>.from(decodedBody.map((x) => DoneeInstitution.fromJson(x)));
    
    return doneeInstitutions;
  }

  Future<DoneeInstitution> findDoneeInstitutionById(int id) async {
    final http.Response response = await http.get(
      Uri.parse("${ApiConstants.doneeInstitutionsUrl}/$id"),
      headers: ApiConstants.headers
    );
    final Map<String, dynamic> decodedBody = json.decode(utf8.decode(response.bodyBytes));
    final DoneeInstitution doneeInstitution = DoneeInstitution.fromJson(decodedBody);

    return doneeInstitution;
  }

  Future<DoneeInstitution> createDoneeInstitution(DoneeInstitution doneeInstitution) async {
    final http.Response response = await http.post(
      Uri.parse(ApiConstants.doneeInstitutionsUrl),
      headers: ApiConstants.headers,
      body: json.encode(doneeInstitution.toJson())
    );
    final Map<String, dynamic> decodedBody = json.decode(utf8.decode(response.bodyBytes));
    final DoneeInstitution createDoneeInstitution = DoneeInstitution.fromJson(decodedBody);

    return createDoneeInstitution;
  }

  Future updateDoneeInstitution(DoneeInstitution doneeInstitution) async {
    final http.Response response = await http.put(
      Uri.parse("${ApiConstants.doneeInstitutionsUrl}/${doneeInstitution.id}"),
      headers: ApiConstants.headers,
      body: json.encode(doneeInstitution.toJson())
    );
  }

  Future deleteDoneeInstitutionById(int id) async {
    final http.Response response = await http.delete(
      Uri.parse("${ApiConstants.doneeInstitutionsUrl}/$id"),
      headers: ApiConstants.headers
    );
  }

}