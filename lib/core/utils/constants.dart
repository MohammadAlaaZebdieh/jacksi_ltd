import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';
import 'app_colors.dart';

class Constants {
  static void showToast(
      {required BuildContext context,
      required String msg,
      Color? color,
      ToastGravity? gravity}) {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9.0),
            topRight: Radius.circular(9.0),
          ),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      gravity: gravity,
    );
  }

  static Widget loadingWithBackground(
      {required BuildContext context,
      BoxDecoration? boxDecoration,
      EdgeInsetsGeometry? padding}) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: boxDecoration ??
          BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
          ),
      padding: padding ?? EdgeInsets.only(top: context.height * 0.25),
      child: Center(
        child: SpinKitWave(
          color: AppColors.primary,
          size: context.width * 0.15,
          itemCount: 8,
        ),
      ),
    );
  }
}
