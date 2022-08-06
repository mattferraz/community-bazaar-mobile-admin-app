import 'dart:convert';
import 'package:bazaar_adm/utils/api_response_handler.dart';
import 'package:http/http.dart' as http;

import 'package:bazaar_adm/constants/api_constants.dart';
import '../models/donee_institution.dart';

class DoneeInstitutionService {

  final Map<String, String> headers = ApiConstants.headers;
  final String doneeInstitutionsUrl = ApiConstants.doneeInstitutionsUrl;

  Future<List<DoneeInstitution>> findAllDoneeInstitutions() async {
    final http.Response response = await http.get(
      Uri.parse(doneeInstitutionsUrl),
      headers: headers
    );
    final Iterable<dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final List<DoneeInstitution> doneeInstitutions = List<DoneeInstitution>.from(decodedBody.map((x) => DoneeInstitution.fromJson(x)));
    
    return doneeInstitutions;
  }

  Future<DoneeInstitution> findDoneeInstitutionById(int id) async {
    final http.Response response = await http.get(
      Uri.parse("$doneeInstitutionsUrl/$id"),
      headers: headers
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final DoneeInstitution doneeInstitution = DoneeInstitution.fromJson(decodedBody);

    return doneeInstitution;
  }

  Future<DoneeInstitution> createDoneeInstitution(DoneeInstitution doneeInstitution) async {
    final http.Response response = await http.post(
      Uri.parse(doneeInstitutionsUrl),
      headers: headers,
      body: json.encode(doneeInstitution.toJson())
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final DoneeInstitution createDoneeInstitution = DoneeInstitution.fromJson(decodedBody);

    return createDoneeInstitution;
  }

  Future updateDoneeInstitution(DoneeInstitution doneeInstitution) async {
    final http.Response response = await http.put(
      Uri.parse("$doneeInstitutionsUrl/${doneeInstitution.id}"),
      headers: headers,
      body: json.encode(doneeInstitution.toJson())
    );
    ApiResponseHandler.handleApiReponse(response);
  }

  Future deleteDoneeInstitutionById(int id) async {
    final http.Response response = await http.delete(
      Uri.parse("$doneeInstitutionsUrl/$id"),
      headers: headers
    );
    ApiResponseHandler.handleApiReponse(response);
  }

}