import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/hex_color.dart';
import '../../domain/entities/product_response.dart';

class ItemProductHorizontal extends StatelessWidget {
  final ProductResponse product;
  final int index;
  const ItemProductHorizontal(
      {super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 115,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              image: DecorationImage(
                  image: FileImage(File(product.images!.first)),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: context.width / 2,
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
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    product.price.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
              const SizedBox(
                height: 8,
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
