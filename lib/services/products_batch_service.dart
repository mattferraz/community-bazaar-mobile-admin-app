import 'dart:convert';

import 'package:bazaar_adm/constants/api_constants.dart';
import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/models/products_batch.dart';
import 'package:bazaar_adm/utils/api_response_handler.dart';
import 'package:http/http.dart' as http;

class ProductsBatchService {
  
  final Map<String, String> headers = ApiConstants.headers;
  final String productsBatchesUrl = ApiConstants.productsBatchesUrl;

  Future<ProductsBatch> findProductsBatchById(int id) async {
    final http.Response response = await http.get(
      Uri.parse("$productsBatchesUrl/$id"),
      headers: headers
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final ProductsBatch productsBatch = ProductsBatch.fromJson(decodedBody);

    return productsBatch;
  }

  Future<List<ProductsBatch>> findAllProductsBatches() async {
    final http.Response response = await http.get(
      Uri.parse(productsBatchesUrl),
      headers: headers
    );
    final Iterable<dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    List<ProductsBatch> productsBatches = List<ProductsBatch>.from(decodedBody.map((e) => ProductsBatch.fromJson(e)));
    
    return productsBatches;
  }

  Future<List<Product>> findAllProductsFromProductBatchId(int id) async {
    final http.Response response = await http.get(
      Uri.parse("$productsBatchesUrl/$id/products"),
      headers: headers
    );
    final Iterable<dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final List<Product> products = List<Product>.from(decodedBody.map((e) => Product.fromJson(e)));

    return products;
  }

  Future<ProductsBatch> createProductsBatch(ProductsBatch productsBatch) async {
    final http.Response response = await http.post(
      Uri.parse(productsBatchesUrl),
      headers: headers,
      body: json.encode(productsBatch.toJson())
    );
    final Map<String, dynamic> decodedBody = ApiResponseHandler.handleApiReponse(response);
    final ProductsBatch createdProductsBatch = ProductsBatch.fromJson(decodedBody);

    return createdProductsBatch;
  }

  Future<void> updateProductsBatch(ProductsBatch productsBatch) async {
    final http.Response response = await http.put(
      Uri.parse("$productsBatchesUrl/${productsBatch.id}"),
      headers: headers,
      body: json.encode(productsBatch.toJson())
    );
    ApiResponseHandler.handleApiReponse(response);
  }

  Future<void> deleteProductsBatchById(int id) async {
    final http.Response response = await http.delete(
      Uri.parse("$productsBatchesUrl/$id"),
      headers: headers,
    );
    ApiResponseHandler.handleApiReponse(response);
  }

}