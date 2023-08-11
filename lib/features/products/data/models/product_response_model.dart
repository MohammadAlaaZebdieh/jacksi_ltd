
import 'package:jacksi_ltd/core/utils/app_strings.dart';

import '../../domain/entities/product_response.dart';

// ignore: must_be_immutable
class ProductResponseModel extends ProductResponse {
  ProductResponseModel({
    required int id,
    required String productName,
    required String storeName,
    required double price,
    required int category,
    List<String>? images,
  }) : super(
          id: id,
          productName: productName,
          storeName: storeName,
          price: price,
          category: category,
          images: images,
        );

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        id: json[AppStrings.columnId],
        productName: json[AppStrings.columnProductName],
        storeName: json[AppStrings.columnStoreName],
        price: json[AppStrings.columnPrice],
        category: json[AppStrings.columnCategory],
      );
}
