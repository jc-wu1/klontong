import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../entity/product_entity.dart';
import '../entity/products_entity.dart';

abstract class ProductsRepository {
  Future<Either<NetworkExceptions, ProductsEntity>> getProducts({
    int page = 1,
    int limit = 10,
    String? query,
  });

  Future<Either<NetworkExceptions, ProductEntity>> getProductDetail({
    required String productId,
  });
}
