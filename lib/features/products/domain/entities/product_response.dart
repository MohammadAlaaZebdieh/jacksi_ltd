
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductResponse extends Equatable {
  final int id;
  final String productName;
  final String storeName;
  final double price;
  final int category;
  List<String>? images;

  ProductResponse({
    required this.id,
    required this.productName,
    required this.storeName,
    required this.price,
    required this.category,
    this.images,
  });

  @override
  List<Object?> get props =>
      [id, productName, storeName, price, category, images];
}
