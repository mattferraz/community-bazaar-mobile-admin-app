import 'dart:convert';
import 'package:bazaar_adm/utils/api_response_handler.dart';
import 'package:http/http.dart' as http;

import 'package:bazaar_adm/constants/api_constants.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';

class SupervisoryOrganService {

  final Map<String, String> headers = ApiConstants.headers;
  final String supervisoryOrgansUrl = ApiConstants.supervisoryOrgansUrl;

  Future<List<SupervisoryOrgan>> findAllSupervisoryOrgans() async {
    final http.Response response = await http.get(
      Uri.parse(supervisoryOrgansUrl),
      headers: headers,
    );
    final Iterable<dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final List<SupervisoryOrgan> supervisoryOrgans = List<SupervisoryOrgan>.from(decodedBody.map((x) => SupervisoryOrgan.fromJson(x)));

    return supervisoryOrgans;
  }

  Future<SupervisoryOrgan?> findSupervisoryOrganById(int id) async {
    final http.Response response = await http.get(
      Uri.parse("$supervisoryOrgansUrl/$id"),
      headers: headers,
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final SupervisoryOrgan supervisoryOrgan = SupervisoryOrgan.fromJson(decodedBody);

    return supervisoryOrgan;
  }

  Future<SupervisoryOrgan> createSupervisoryOrgan(SupervisoryOrgan supervisoryOrgan) async {
    final http.Response response = await http.post(
      Uri.parse(supervisoryOrgansUrl),
      headers: headers,
      body: json.encode(supervisoryOrgan.toJson())
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final SupervisoryOrgan supervisoryOrganCreated = SupervisoryOrgan.fromJson(decodedBody);

    return supervisoryOrganCreated;
  }

  Future<void> updateSupervisoryOrgan(SupervisoryOrgan supervisoryOrgan) async {
    final http.Response response = await http.put(
      Uri.parse("$supervisoryOrgansUrl/${supervisoryOrgan.id}"),
      headers: headers,
      body: json.encode(supervisoryOrgan.toJson())
    );
    ApiResponseHandler.handleApiReponse(response);
  }

  Future<void> deleteSupervisoryOrgan(int id) async {
    final http.Response response = await http.delete(
      Uri.parse("$supervisoryOrgansUrl/$id"),
      headers: headers,
    );
    ApiResponseHandler.handleApiReponse(response);
  }
  
}