import 'package:jacksi_ltd/core/utils/app_strings.dart';

class Product {
  int? id;
  String productName;
  String storeName;
  int category;
  double price;

  Product(
      {this.id,
      required this.category,
      required this.storeName,
      required this.price,
      required this.productName});

  Map<String, Object?> toJson() => {
        AppStrings.columnCategory: category,
        AppStrings.columnStoreName: storeName,
        AppStrings.columnPrice: price,
        AppStrings.columnProductName: productName,
      };
}
