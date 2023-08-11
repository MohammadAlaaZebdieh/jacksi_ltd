import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product_response.dart';
import '../usecases/add_product_usecase.dart';

abstract class ProductRepository {
  Future<Either<Failure, bool>> addProduct(ProductParams params);
  Future<Either<Failure, List<ProductResponse>>> getAllProducts(int category);
}