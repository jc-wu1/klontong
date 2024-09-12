import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../domain/entity/products_entity.dart';
import '../../domain/repository/products_repository.dart';
import '../datasource/products_datasource.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  ProductsRepositoryImpl({
    required ProductsDatasource remoteDataSource,
  }) : _remoteDatasource = remoteDataSource;

  final ProductsDatasource _remoteDatasource;

  @override
  Future<Either<NetworkExceptions, ProductsEntity>> getProducts({
    int page = 1,
    int limit = 10,
    String? query,
  }) async {
    try {
      final response = await _remoteDatasource.fetchProducts(
        page: page,
        limit: limit,
        query: query,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(NetworkExceptions.fromDio(e));
    } catch (e) {
      return Left(NetworkExceptions.general(e.toString()));
    }
  }
}
