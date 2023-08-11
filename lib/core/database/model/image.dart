import '../../utils/app_strings.dart';

class Image {
  int? id;
  String imagePath;
  int productId;

  Image({this.id, required this.imagePath, required this.productId});

  Map<String, Object?> toJson() => {
        AppStrings.columnImagePath: imagePath,
        AppStrings.columnProductIdFK: productId,
      };
}
