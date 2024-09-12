import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../../products/domain/entity/product_entity.dart';
import '../repository/product_detail_repository.dart';

class ProductDetailUsecases {
  const ProductDetailUsecases({
    required ProductDetailRepository repository,
  }) : _repository = repository;

  final ProductDetailRepository _repository;

  Future<Either<NetworkExceptions, ProductEntity>> getProductDetail({
    required String productId,
  }) async {
    return await _repository.getProductDetail(
      productId: productId,
    );
  }
}
