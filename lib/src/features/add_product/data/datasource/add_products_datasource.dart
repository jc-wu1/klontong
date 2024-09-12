import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants.dart';
import '../../../products/data/model/product_model.dart';

part 'add_products_datasource.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AddProductsDatasource {
  factory AddProductsDatasource(Dio dio, {String baseUrl}) =
      _AddProductsDatasource;

  @POST("products")
  Future<ProductModel> postProduct({
    @Body() required ProductModel payload,
  });
}
