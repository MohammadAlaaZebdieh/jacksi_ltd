import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacksi_ltd/features/products/domain/entities/product_response.dart';
import 'package:jacksi_ltd/features/products/domain/usecases/add_product_usecase.dart';
import 'package:jacksi_ltd/features/products/domain/usecases/get_all_products_usecase.dart';

import '../../../../core/error/failures.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final AddProductUsecase addProductUsecase;
  final GetAllProductUsecase getAllProductUsecase;
  ProductsCubit(
      {required this.addProductUsecase, required this.getAllProductUsecase})
      : super(ProductsInitial());

  Future<void> addProduct(ProductParams params) async {
    emit(AddProductIsLoading());
    Either<Failure, bool> response = await addProductUsecase(params);
    emit(response.fold(
      (failure) => const AddProductError(msg: ""),
      (res) => AddProductSuccess(),
    ));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ProductsInitial());
  }

  Future<void> getAllProduct(int category) async {
    emit(GetAllProductsIsLoading());
    Either<Failure, List<ProductResponse>> response =
        await getAllProductUsecase(category);
    emit(response.fold(
      (failure) => const GetAllProductsError(msg: ""),
      (res) => GetAllProductsSuccess(res: res),
    ));
  }

  Future<void> changeDisplay() async {
    emit(ChangeDisplay());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ProductsInitial());
  }
}
