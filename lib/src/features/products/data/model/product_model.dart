import 'dart:convert';

import '../../domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    super.categoryId,
    super.categoryName,
    super.sku,
    super.name,
    super.description,
    super.image,
    super.price,
    super.id,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        sku: json["sku"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        id: json["id"],
      );

  ProductEntity toEntity() => ProductEntity(
        categoryId: categoryId,
        categoryName: categoryName,
        sku: sku,
        name: name,
        description: description,
        image: image,
        price: price,
        id: id,
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "sku": sku,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "id": id,
      };
}
