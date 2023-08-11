import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksi_ltd/features/products/presentation/screens/add_product_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../features/products/injection_container_product.dart';
import '../../features/products/presentation/cubit/products_cubit.dart';
import '../../features/products/presentation/screens/products_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String addProductRoute = '/addProduct';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => sl<ProductsCubit>()),
            child: const ProductsScreen(),
          );
        }));
      case Routes.addProductRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => sl<ProductsCubit>()),
            child: const AddProductScreen(),
          );
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
