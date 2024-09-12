import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../../products/data/model/product_model.dart';
import '../../../products/domain/entity/product_entity.dart';
import '../../domain/repository/add_products_repository.dart';
import '../datasource/add_products_datasource.dart';

class AddProductsRepositoryImpl extends AddProductsRepository {
  AddProductsRepositoryImpl({
    required AddProductsDatasource remoteDataSource,
  }) : _remoteDatasource = remoteDataSource;

  final AddProductsDatasource _remoteDatasource;

  @override
  Future<Either<NetworkExceptions, ProductEntity>> addProduct({
    required ProductModel payload,
  }) async {
    try {
      final response = await _remoteDatasource.postProduct(
        payload: payload,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(NetworkExceptions.fromDio(e));
    }
  }
}
