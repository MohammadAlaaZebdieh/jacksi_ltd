import 'package:flutter/material.dart';
import 'package:jacksi_ltd/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final void Function() onClickEvent;
  final Color backgroundColor;
  final Widget content;
  final bool? disableBorder;

  const CustomButton({
    super.key,
    required this.onClickEvent,
    required this.backgroundColor,
    required this.content,
    this.disableBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClickEvent,
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
            BorderSide(width: disableBorder == true ? 0 : 1, color: AppColors.border)),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      ),
      child: content,
    );
  }
}
