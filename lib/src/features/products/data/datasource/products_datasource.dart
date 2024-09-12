import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants.dart';
import '../model/products_model.dart';

part 'products_datasource.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductsDatasource {
  factory ProductsDatasource(Dio dio, {String baseUrl}) = _ProductsDatasource;

  @GET("products")
  Future<ProductsModel> fetchProducts({
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
    @Query('search') String? query,
  });
}
