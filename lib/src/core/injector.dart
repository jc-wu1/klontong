import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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

  //! Datasources
  sl.registerLazySingleton<ProductsDatasource>(
    () => ProductsDatasource(
      sl<NetworkInterface>().dio,
    ),
  );

  //! Repositories
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      remoteDataSource: sl<ProductsDatasource>(),
    ),
  );

  //! Usecases
  sl.registerLazySingleton<ProductsUsecases>(
    () => ProductsUsecases(
      repository: sl<ProductsRepository>(),
    ),
  );
}
