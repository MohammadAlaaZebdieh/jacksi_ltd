import 'package:jacksi_ltd/core/database/model/image.dart';
import 'package:jacksi_ltd/core/utils/app_strings.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../../../../core/database/model/product.dart';
import '../../domain/usecases/add_product_usecase.dart';

abstract class ProductLocalDataSource {
  Future<dynamic>? addProduct(ProductParams params);
  Future<dynamic>? getAllProducts(int category);
  Future<dynamic>? getImagesByProductId(int productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<dynamic>? getAllProducts(int category) async {
    final db = await databaseHelper.database;
    if (category == 0) {
      return await db?.query(AppStrings.tableProduct);
    } else {
      return await db?.query(AppStrings.tableProduct,
          where: '${AppStrings.columnCategory} = ?', whereArgs: [category]);
    }
  }

  @override
  Future<dynamic>? getImagesByProductId(int productId) async {
    final db = await databaseHelper.database;
    return await db?.query(AppStrings.tableImage,
        where: '${AppStrings.columnProductIdFK} = ?', whereArgs: [productId]);
  }

  @override
  Future<dynamic>? addProduct(ProductParams params) async {
    final db = await databaseHelper.database;

    final product = Product(
      productName: params.productName,
      storeName: params.storeName,
      price: params.price,
      category: params.category,
    );

    var productId = await db?.insert(
      AppStrings.tableProduct,
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    var batch = db?.batch();

    for (String img in params.images) {
      var imagePath = await img.saveImage();
      var image = Image(imagePath: imagePath, productId: productId!);
      batch?.insert(
        AppStrings.tableImage,
        image.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch?.commit();
    return true;
  }
}
