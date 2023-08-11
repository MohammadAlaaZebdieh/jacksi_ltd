part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class AddProductIsLoading extends ProductsState {}

class AddProductSuccess extends ProductsState {}

class AddProductError extends ProductsState {
  final String msg;

  const AddProductError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class GetAllProductsIsLoading extends ProductsState {}

class GetAllProductsSuccess extends ProductsState {
  final List<ProductResponse> res;

  const GetAllProductsSuccess({required this.res});

  @override
  List<Object> get props => [res];
}

class ChangeDisplay extends ProductsState {}

class GetAllProductsError extends ProductsState {
  final String msg;

  const GetAllProductsError({required this.msg});

  @override
  List<Object> get props => [msg];
}
