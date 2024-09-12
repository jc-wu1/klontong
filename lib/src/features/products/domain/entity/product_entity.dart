import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? categoryId;
  final String? categoryName;
  final String? sku;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final String? id;

  const ProductEntity({
    this.categoryId,
    this.categoryName,
    this.sku,
    this.name,
    this.description,
    this.image,
    this.price,
    this.id,
  });

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
        sku,
        name,
        description,
        image,
        price,
        id,
      ];
}
