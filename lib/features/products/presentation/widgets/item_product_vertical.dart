import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';
import 'package:jacksi_ltd/features/products/domain/entities/product_response.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/hex_color.dart';

class ItemProductVertical extends StatelessWidget {
  final ProductResponse product;
  final int index;
  const ItemProductVertical({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 114,
          height: 115,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            image: DecorationImage(
                image: FileImage(File(product.images!.first)), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 115,
          width: context.width - 144,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.basicBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    " دولار",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: HexColor("#EEEEEE")),
                child: Text(
                  product.storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
