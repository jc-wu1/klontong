import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../../products/data/model/product_model.dart';
import '../../../products/domain/entity/product_entity.dart';
import '../repository/add_products_repository.dart';

class AddProductUsecases {
  const AddProductUsecases({
    required AddProductsRepository repository,
  }) : _repository = repository;

  final AddProductsRepository _repository;

  Future<Either<NetworkExceptions, ProductEntity>> addProduct({
    required ProductModel payload,
  }) async {
    return await _repository.addProduct(
      payload: payload,
    );
  }
}
