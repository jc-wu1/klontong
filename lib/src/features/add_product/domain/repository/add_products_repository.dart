import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../../products/data/model/product_model.dart';
import '../../../products/domain/entity/product_entity.dart';

abstract class AddProductsRepository {
  Future<Either<NetworkExceptions, ProductEntity>> addProduct({
    required ProductModel payload,
  });
}
