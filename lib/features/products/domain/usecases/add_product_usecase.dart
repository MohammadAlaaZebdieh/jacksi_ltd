import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase implements UseCase<bool, ProductParams> {
  final ProductRepository productRepository;

  AddProductUsecase({required this.productRepository});
  @override
  Future<Either<Failure, bool>> call(ProductParams params) =>
      productRepository.addProduct(params);
}

class ProductParams extends Equatable {
  final String productName;
  final String storeName;
  final double price;
  final int category;
  final List<String> images;

  const ProductParams(
      {required this.productName,
      required this.storeName,
      required this.price,
      required this.category,
      required this.images});

  @override
  List<Object?> get props => [productName, storeName, price, category, images];

  Map<String, Object?> toJson() => {
        AppStrings.columnCategory: category,
        AppStrings.columnStoreName: storeName,
        AppStrings.columnPrice: price,
        AppStrings.columnProductName: productName,
      };
}
