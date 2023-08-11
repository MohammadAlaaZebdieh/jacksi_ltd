import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jacksi_ltd/core/utils/app_colors.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';
import 'package:jacksi_ltd/features/products/domain/entities/product_response.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/products_cubit.dart';
import '../widgets/item_product_horizontal.dart';
import '../widgets/item_product_vertical.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductResponse>? _products;
  bool _isLoading = false;
  bool _isHorizontal = false;
  int _category = 0;

  _getAllProducts() =>
      BlocProvider.of<ProductsCubit>(context).getAllProduct(_category);

  @override
  void initState() {
    _getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
        builder: (BuildContext context, state) {
      if (state is GetAllProductsIsLoading) {
        _isLoading = true;
      } else {
        _isLoading = false;
      }
      if (state is GetAllProductsSuccess) {
        _products = state.res;
      }
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 32,
                    top: MediaQuery.of(context).padding.top + 5,
                    bottom: 5,
                    end: 32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "المنتجات",
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CustomButton(
                          content: SvgPicture.asset(
                            VectorAssets.add,
                            width: 17.5,
                            height: 17.5,
                          ),
                          onClickEvent: () {
                            Navigator.of(context)
                                .pushNamed(Routes.addProductRoute)
                                .then((result) {
                              _getAllProducts();
                            });
                          },
                          backgroundColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10),
                          child: Text(
                            "التصنيفات",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 8),
                          child: SizedBox(
                            width: context.width,
                            height: 114,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              separatorBuilder: (ctx, index) {
                                return const SizedBox(
                                  width: 5,
                                );
                              },
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    _category = index;
                                    _getAllProducts();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: index == _category
                                              ? AppColors.primary
                                              : AppColors.white,
                                        ),
                                        color: AppColors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 82,
                                          height: 66,
                                          padding: index == 0
                                              ? const EdgeInsets.all(20)
                                              : EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(9),
                                            ),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  index == 0
                                                      ? ImgAssets.viewAll
                                                      : index == 1
                                                          ? ImgAssets
                                                              .categoryOne
                                                          : index == 2
                                                              ? ImgAssets
                                                                  .categoryTwo
                                                              : ImgAssets
                                                                  .categoryThree,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Text(
                                          index == 0
                                              ? "عرض الكل"
                                              : "تصنيف $index",
                                          style: TextStyle(
                                            color: AppColors.basicBlack,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 230,
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(9),
                                ),
                                color: AppColors.white),
                            child: InkWell(
                              onTap: () {
                                _isHorizontal = !_isHorizontal;
                                BlocProvider.of<ProductsCubit>(context)
                                    .changeDisplay();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    VectorAssets.displayType,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _isHorizontal
                                          ? "تغيير عرض المنتجات الى رأسي"
                                          : "تغيير عرض المنتجات الى افقي",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8),
                          child: _products != null
                              ? _products!.isEmpty
                                  ? SizedBox(
                                      height: context.height - 310,
                                      child: Center(
                                        child: Text(
                                          _category == 0
                                              ? "لا يوجد منتجات مضافة بعد..."
                                              : "لا يوجد منتجات مضافة لهذا الصنف بعد...",
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  : GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _products!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: _isHorizontal ? 2 : 1,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 2.0,
                                        childAspectRatio:
                                            _isHorizontal ? 0.75 : 3,
                                      ),
                                      itemBuilder: (ctx, index) {
                                        var item = _products![index];
                                        return _isHorizontal
                                            ? ItemProductHorizontal(
                                                index: index,
                                                product: item,
                                              )
                                            : ItemProductVertical(
                                                index: index,
                                                product: item,
                                              );
                                      },
                                    )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _isLoading
                ? Constants.loadingWithBackground(context: context)
                : Container(),
          ],
        ),
      );
    });
  }
}
