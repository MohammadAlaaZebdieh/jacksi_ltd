import 'package:dartz/dartz.dart';
import 'package:jacksi_ltd/features/products/domain/entities/product_response.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class GetAllProductUsecase implements UseCase<List<ProductResponse>, int> {
  final ProductRepository productRepository;

  GetAllProductUsecase({required this.productRepository});
  @override
  Future<Either<Failure, List<ProductResponse>>> call(int category) =>
      productRepository.getAllProducts(category);
}
