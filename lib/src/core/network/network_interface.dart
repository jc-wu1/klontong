import 'package:dio/dio.dart';

class NetworkInterface {
  final Dio _dio = Dio();

  Dio get dio => _dio
    ..interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      ],
    );
}
