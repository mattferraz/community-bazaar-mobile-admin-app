import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class ApiResponseHandler {

  static handleApiReponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        final decodedJson = json.decode(utf8.decode(response.bodyBytes));
        return decodedJson;
      case 204:
        return null;
      default:
        throw HttpException(response.reasonPhrase.toString());
    }
  }

}