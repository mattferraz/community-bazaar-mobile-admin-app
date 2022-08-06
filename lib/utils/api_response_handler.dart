import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class ApiResponseHandler {

  static handleApiReponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        final decodedJson = json.decode(utf8.decode(response.bodyBytes));
        return decodedJson;
      default:
        throw HttpException(response.reasonPhrase.toString());
    }
  }

}