import 'package:get_it/get_it.dart';
import 'package:jacksi_ltd/features/products/domain/repositories/product_repository.dart';
import 'package:jacksi_ltd/features/products/domain/usecases/add_product_usecase.dart';
import 'package:jacksi_ltd/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:jacksi_ltd/features/products/presentation/cubit/products_cubit.dart';

import 'data/datasources/product_local_data_source.dart';
import 'data/repositories/product_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory<ProductsCubit>(() => ProductsCubit(
        addProductUsecase: sl(),
        getAllProductUsecase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton<AddProductUsecase>(
      () => AddProductUsecase(productRepository: sl()));
  sl.registerLazySingleton<GetAllProductUsecase>(
      () => GetAllProductUsecase(productRepository: sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productLocalDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(databaseHelper: sl()));
}
