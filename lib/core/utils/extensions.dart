import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
  double getResponsiveSize(double fontSize) {
    return fontSize * (MediaQuery.of(this).size.width) / 375.0;
  }
}

extension StringExtension on String {
  Future<String> saveImage() async {
    final DateTime now = DateTime.now();
    final file = File(this);
    final imageBytes = await file.readAsBytes();
    final Uint8List assetsFile = imageBytes.buffer
        .asUint8List(imageBytes.offsetInBytes, imageBytes.lengthInBytes);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/image';
    directory = Directory(path);
    if (!await directory.exists()) await Directory(path).create();
    path = '$path/${now.toString()}.png';
    File newImgFile = File(path);
    await newImgFile.writeAsBytes(assetsFile);
    return newImgFile.path;
  }
}
