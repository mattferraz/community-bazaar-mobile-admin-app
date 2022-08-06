import 'dart:convert';

import 'package:bazaar_adm/constants/api_constants.dart';
import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/utils/api_response_handler.dart';
import 'package:http/http.dart' as http;

class ProductService {
  
  final String productsUrl = ApiConstants.productsUrl;
  final Map<String, String> headers = ApiConstants.headers;

  Future<Product> findProductById(int id) async {
    final http.Response response = await http.get(
      Uri.parse("$productsUrl/$id"),
      headers: headers
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final Product product = Product.fromJson(decodedBody);

    return product;
  }

  Future<List<Product>> findAllProducts() async {
    final http.Response response = await http.get(
      Uri.parse(productsUrl),
      headers: headers
    );
    final Iterable<dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final List<Product> products = List<Product>.from(decodedBody.map((e) => Product.fromJson(e)));
    
    return products;
  }

  Future<Product> createProduct(Product product) async {
    final http.Response response = await http.post(
      Uri.parse(productsUrl),
      headers: headers,
      body: json.encode(product.toJson())
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final Product createProduct = Product.fromJson(decodedBody);

    return createProduct;
  }

  Future<void> updateProduct(Product product) async {
    final http.Response response = await http.put(
      Uri.parse("$productsUrl/${product.id}"),
      headers: headers,
      body: json.encode(product.toJson())
    );
    ApiResponseHandler.handleApiReponse(response);
  }

  Future<void> deleteProduct(int id) async {
    final http.Response response = await http.delete(
      Uri.parse("$productsUrl/$id"),
      headers: headers
    );
    ApiResponseHandler.handleApiReponse(response);
  }

}