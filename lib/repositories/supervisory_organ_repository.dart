import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bazaar_adm/constants/api_constants.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';

class SupervisoryOrganRepository {

  Future<List<SupervisoryOrgan>> findAllSupervisoryOrgans() async {
    final http.Response response = await http.get(
      Uri.parse(ApiConstants.supervisoryOrgansUrl),
      headers: ApiConstants.headers,
    );
    Iterable<Map<String, dynamic>> decodedBody = json.decode(utf8.decode(response.bodyBytes));
    List<SupervisoryOrgan> supervisoryOrgans = List<SupervisoryOrgan>.from(decodedBody.map((x) => SupervisoryOrgan.fromJson(x)));

    return supervisoryOrgans;
  }

  Future<SupervisoryOrgan?> findSupervisoryOrganById(int id) async {
    final http.Response response = await http.get(
      Uri.parse("${ApiConstants.supervisoryOrgansUrl}/$id"),
      headers: ApiConstants.headers,
    );
    Map<String, dynamic> decodedBody = json.decode(utf8.decode(response.bodyBytes));
    SupervisoryOrgan supervisoryOrgan = SupervisoryOrgan.fromJson(decodedBody);

    return supervisoryOrgan;
  }

  Future<SupervisoryOrgan?> createSupervisoryOrgan(SupervisoryOrgan supervisoryOrgan) async {
    final http.Response response = await http.post(
      Uri.parse(ApiConstants.supervisoryOrgansUrl),
      headers: ApiConstants.headers,
      body: json.encode(supervisoryOrgan.toJson())
    );
    Map<String, dynamic> decodedBody = json.decode(utf8.decode(response.bodyBytes));
    SupervisoryOrgan supervisoryOrganCreated = SupervisoryOrgan.fromJson(decodedBody);

    return supervisoryOrganCreated;
  }

  Future updateSupervisoryOrgan(SupervisoryOrgan supervisoryOrgan) async {
    final http.Response response = await http.put(
      Uri.parse("${ApiConstants.supervisoryOrgansUrl}/${supervisoryOrgan.id}"),
      headers: ApiConstants.headers,
      body: json.encode(supervisoryOrgan.toJson())
    );
  }

  Future deleteSupervisoryOrgan(int id) async {
    final http.Response response = await http.delete(
      Uri.parse("${ApiConstants.supervisoryOrgansUrl}/$id"),
      headers: ApiConstants.headers,
    );
  }
  
}