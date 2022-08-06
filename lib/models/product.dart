import 'package:bazaar_adm/models/products_batch.dart';

class Product {
  int? id;
  String name;
  String brand;
  String category;
  String? description;
  ProductsBatch? productsBatch;

  Product({
    this.id,
    required this.name,
    required this.brand,
    required this.category,
    this.description,
    this.productsBatch
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"], 
    brand: json["brand"], 
    category: json["category"], 
    description: json["description"],
    productsBatch: ProductsBatch.fromJson(json["productsBatch"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "brand": brand,
    "category": category,
    "description": description,
    "productsBatch": productsBatch?.toJson()
  };
}