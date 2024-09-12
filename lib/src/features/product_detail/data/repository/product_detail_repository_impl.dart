import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/exeptions/network_exceptions.dart';
import '../../../products/domain/entity/product_entity.dart';
import '../../domain/repository/product_detail_repository.dart';
import '../datasource/product_detail_datasource.dart';

class ProductDetailRepositoryImpl extends ProductDetailRepository {
  ProductDetailRepositoryImpl({
    required ProductDetailDatasource remoteDataSource,
  }) : _remoteDatasource = remoteDataSource;

  final ProductDetailDatasource _remoteDatasource;

  @override
  Future<Either<NetworkExceptions, ProductEntity>> getProductDetail({
    required String productId,
  }) async {
    try {
      final response = await _remoteDatasource.fetchProductDetail(
        productId: productId,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(NetworkExceptions.fromDio(e));
    }
  }
}
