import '../../domain/entity/products_entity.dart';
import 'product_model.dart';

class ProductsModel extends ProductsEntity {
  const ProductsModel({
    List<ProductModel>? products,
  }) : super(
          products: products,
        );

  factory ProductsModel.fromJson(List<dynamic> json) {
    return ProductsModel(
      products: json.isEmpty
          ? []
          : json
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList(),
    );
  }

  ProductsEntity toEntity() => ProductsEntity(
        products: products,
      );
}
