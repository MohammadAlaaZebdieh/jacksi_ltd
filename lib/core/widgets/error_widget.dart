import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';

class ErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String? errorText;
  const ErrorWidget({Key? key, this.onPress, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: AppColors.primary,
          size: 125,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(
            errorText ?? "حدث خطأ ما",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.basicBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        errorText == null
            ? Text(
                "حاول مجددا",
                style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          onClickEvent: () {
            if (onPress != null) {
              onPress!();
            }
          },
          content: Text(
            "اعادة تحميل الصفح",
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
