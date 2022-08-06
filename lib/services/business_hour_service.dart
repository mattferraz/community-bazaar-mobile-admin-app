import 'dart:convert';

import 'package:bazaar_adm/constants/api_constants.dart';
import 'package:bazaar_adm/models/business_hour.dart';
import 'package:bazaar_adm/utils/api_response_handler.dart';
import 'package:http/http.dart' as http;

class BusinessHourService {

  Map<String, String> headers = ApiConstants.headers;

  Future<List<BusinessHour>> findAllBusinessHourFromDoneeInstitution(int doneeInstitutionId) async {
    final http.Response response = await http.get(
      Uri.parse(ApiConstants.getBusinessHoursUrl(doneeInstitutionId)),
      headers: headers,
    );
    final Iterable<dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    List<BusinessHour> businessHours = List<BusinessHour>.from(decodedBody.map((e) => BusinessHour.fromJson(e)));
    
    return businessHours;
  }

  Future<BusinessHour> createBusinessHour(int doneeInstitutionId, BusinessHour businessHour) async {
    final http.Response response = await http.post(
      Uri.parse(ApiConstants.getBusinessHoursUrl(doneeInstitutionId)),
      headers: headers,
      body: json.encode(businessHour.toJson())
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final BusinessHour createdBusinessHour = BusinessHour.fromJson(decodedBody);

    return createdBusinessHour;
  }

  Future<void> updateBusinessHour(BusinessHour businessHour) async {
    final http.Response response = await http.put(
      Uri.parse("${ApiConstants.getBusinessHoursUrl(businessHour.doneeInstitution.id)}/${businessHour.id}"),
      headers: headers,
      body: json.encode(businessHour.toJson())
    );
    ApiResponseHandler.handleApiReponse(response);
  }

  Future<void> deleteBusinessHourById(int doneeInstitutionId, int id) async {
    final http.Response response = await http.delete(
      Uri.parse("${ApiConstants.getBusinessHoursUrl(doneeInstitutionId)}/$id"),
      headers: headers
    );
    ApiResponseHandler.handleApiReponse(response);
  }

}