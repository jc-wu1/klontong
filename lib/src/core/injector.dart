import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/add_product/data/datasource/add_products_datasource.dart';
import '../features/add_product/data/repository/add_products_repository_impl.dart';
import '../features/add_product/domain/repository/add_products_repository.dart';
import '../features/add_product/domain/usecases/add_products_usecases.dart';
import '../features/authentication/data/datasource/authentication_local_data_source.dart';
import '../features/authentication/data/repository/authentication_repository_impl.dart';
import '../features/authentication/domain/repository/authentication_repository.dart';
import '../features/authentication/domain/usecase/authentication_usecases.dart';
import '../features/product_detail/data/datasource/product_detail_datasource.dart';
import '../features/product_detail/data/repository/product_detail_repository_impl.dart';
import '../features/product_detail/domain/repository/product_detail_repository.dart';
import '../features/product_detail/domain/usecases/product_detail_usecases.dart';
import '../features/products/data/datasource/products_datasource.dart';
import '../features/products/data/repository/products_repository_impl.dart';
import '../features/products/domain/repository/products_repository.dart';
import '../features/products/domain/usecases/products_usecases.dart';
import 'network/network_interface.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //! Dio
  sl.registerLazySingleton<NetworkInterface>(
    () => NetworkInterface(),
  );
  sl.registerLazySingleton<Dio>(() => sl<NetworkInterface>().dio);

  //! SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! Datasources
  sl.registerLazySingleton<ProductsDatasource>(
    () => ProductsDatasource(
      sl<NetworkInterface>().dio,
    ),
  );
  sl.registerLazySingleton<AddProductsDatasource>(
    () => AddProductsDatasource(
      sl<NetworkInterface>().dio,
    ),
  );
  sl.registerLazySingleton<ProductDetailDatasource>(
    () => ProductDetailDatasource(
      sl<NetworkInterface>().dio,
    ),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(
      sl(),
    ),
  );

  //! Repositories
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      remoteDataSource: sl<ProductsDatasource>(),
    ),
  );
  sl.registerLazySingleton<AddProductsRepository>(
    () => AddProductsRepositoryImpl(
      remoteDataSource: sl<AddProductsDatasource>(),
    ),
  );
  sl.registerLazySingleton<ProductDetailRepository>(
    () => ProductDetailRepositoryImpl(
      remoteDataSource: sl<ProductDetailDatasource>(),
    ),
  );
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      localDataSource: sl<AuthenticationLocalDataSource>(),
    ),
  );

  //! Usecases
  sl.registerLazySingleton<ProductsUsecases>(
    () => ProductsUsecases(
      repository: sl<ProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<AddProductUsecases>(
    () => AddProductUsecases(
      repository: sl<AddProductsRepository>(),
    ),
  );
  sl.registerLazySingleton<ProductDetailUsecases>(
    () => ProductDetailUsecases(
      repository: sl<ProductDetailRepository>(),
    ),
  );
  sl.registerLazySingleton<AuthenticationUsecases>(
    () => AuthenticationUsecases(
      repository: sl<AuthenticationRepository>(),
    ),
  );
}
