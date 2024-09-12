import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../entity/products_entity.dart';
import '../repository/products_repository.dart';

class ProductsUsecases {
  const ProductsUsecases({
    required ProductsRepository repository,
  }) : _repository = repository;

  final ProductsRepository _repository;

  Future<Either<NetworkExceptions, ProductsEntity>> getProducts({
    int page = 1,
    int limit = 10,
    String? query,
  }) async {
    return await _repository.getProducts(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
