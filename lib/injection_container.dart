import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/routes/navigation_service.dart';
import 'package:jacksi_ltd/features/products/injection_container_product.dart'
    as di_products;

import 'core/database/database_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //! Config
  sl.registerLazySingleton(() => NavigationService());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! di
  await di_products.init();
}
