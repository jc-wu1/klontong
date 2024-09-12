import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../../products/domain/entity/product_entity.dart';

abstract class ProductDetailRepository {
  Future<Either<NetworkExceptions, ProductEntity>> getProductDetail({
    required String productId,
  });
}
