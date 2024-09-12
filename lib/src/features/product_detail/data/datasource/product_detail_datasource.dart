import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants.dart';
import '../../../products/data/model/product_model.dart';

part 'product_detail_datasource.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProductDetailDatasource {
  factory ProductDetailDatasource(Dio dio, {String baseUrl}) =
      _ProductDetailDatasource;

  @GET("products/{productId}")
  Future<ProductModel> fetchProductDetail({
    @Path("productId") required String productId,
  });
}
