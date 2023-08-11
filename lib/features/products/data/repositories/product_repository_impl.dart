
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/product_response.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../datasources/product_local_data_source.dart';
import '../models/product_response_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;

  ProductRepositoryImpl({required this.productLocalDataSource});

  @override
  Future<Either<Failure, bool>> addProduct(ProductParams params) async {
    try {
      final response = await productLocalDataSource.addProduct(params);
      if (response != null && response) {
        return const Right(true);
      }
      return Left(CacheFailure());
    } on CacheException catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductResponse>>> getAllProducts(int category) async {
    try {
      List<ProductResponseModel> res = [];
      final productResponse = await productLocalDataSource.getAllProducts(category);
      if (productResponse != null) {
        for (var elementProduct in (productResponse as List)) {
          var product = ProductResponseModel.fromJson(elementProduct);
          var imagesResponse = await productLocalDataSource.getImagesByProductId(product.id);
          product.images = [];
          for (var elementImage in (imagesResponse as List)){
            product.images!.add(elementImage[AppStrings.columnImagePath]);
          }
          res.add(product);
        }
        return Right(res);
      }
      return Left(CacheFailure());
    } on CacheException catch (e) {
      return Left(CacheFailure(e));
    }
  }
}
