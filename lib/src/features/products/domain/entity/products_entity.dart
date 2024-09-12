import 'package:equatable/equatable.dart';

import 'product_entity.dart';

class ProductsEntity extends Equatable {
  final List<ProductEntity>? products;

  const ProductsEntity({
    required this.products,
  });

  @override
  List<Object?> get props => [
        products,
      ];
}
