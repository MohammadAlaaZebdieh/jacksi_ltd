import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String hint;
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.onEditingComplete,
      required this.textInputType,
      required this.controller,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.basicBlack,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(14),
            ),
            border: Border.all(
              width: 1,
              color: AppColors.border,
            ),
            color: AppColors.white,
          ),
          child: TextField(
            keyboardType: textInputType,
            cursorColor: AppColors.black,
            controller: controller,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 30),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsetsDirectional.only(
                bottom: 12,
                top: 12,
                start: 12,
                end: 12
              ),
              counterText: "",
              labelStyle: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              helperStyle: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            style: TextStyle(
                color: AppColors.basicBlack, fontWeight: FontWeight.w300, fontSize: 16),
            onChanged: onChanged ?? (text) {},
            onEditingComplete: onEditingComplete ?? () {},
          ),
        ),
      ],
    );
  }
}
