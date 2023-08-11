import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jacksi_ltd/core/utils/constants.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';
import 'package:jacksi_ltd/features/products/domain/usecases/add_product_usecase.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/select_model.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/products_cubit.dart';
import '../widgets/choose_source_files_bottom_sheet.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final List<SelectModel> _categories = [
    const SelectModel(id: "1", value: "تصنيف 1"),
    const SelectModel(id: "2", value: "تصنيف 2"),
    const SelectModel(id: "3", value: "تصنيف 3"),
  ];

  List<String> _images = [];

  SelectModel? _selectedCategory;

  final TextEditingController _productNameController = TextEditingController();

  final TextEditingController _storeNameController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  bool _isLoading = false;
  bool _isValidProductName = false;
  bool _isValidStoreName = false;
  bool _isValidPrice = false;
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          Constants.showToast(
            context: context,
            msg: "تم الاضافة بنجاح",
            color: AppColors.primary,
            gravity: ToastGravity.SNACKBAR,
          );
        }
        if (state is AddProductError) {
          Constants.showToast(
            context: context,
            msg: "فشلت عمليت الاضافة",
            color: AppColors.red,
            gravity: ToastGravity.SNACKBAR,
          );
        }
      },
      child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (BuildContext context, state) {
        if (state is AddProductIsLoading) {
          _isLoading = true;
        } else {
          _isLoading = false;
        }
        if (state is AddProductSuccess) {
          _productNameController.text = "";
          _storeNameController.text = "";
          _priceController.text = "";
          _isSubmitted = false;
          _selectedCategory = null;
          _images = [];
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 15,
                        top: MediaQuery.of(context).padding.top + 5,
                        bottom: 5,
                        end: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CustomButton(
                              content: SvgPicture.asset(
                                VectorAssets.back,
                                width: 17.5,
                                height: 17.5,
                              ),
                              onClickEvent: () {
                                Navigator.pop(context);
                              },
                              backgroundColor: AppColors.white,
                            ),
                          ),
                          Text(
                            "اضافة منتجات",
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 10),
                              child: Text(
                               _images.isNotEmpty
                                ?  "صور المنتج" : "",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            _images.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10, top: 8),
                                    child: SizedBox(
                                      width: context.width,
                                      height: 114,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _images.length,
                                        separatorBuilder: (ctx, index) {
                                          return const SizedBox(
                                            width: 5,
                                          );
                                        },
                                        itemBuilder: (ctx, index) {
                                          return Container(
                                            width: 97,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(_images[index])),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _images.remove(_images[index]);
                                                });
                                              },
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    VectorAssets.close,
                                                    width: 23,
                                                    height: 23,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 60,
                                child: CustomButton(
                                  disableBorder: true,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                            color: AppColors.white),
                                        child: SvgPicture.asset(
                                          VectorAssets.add,
                                          width: 15,
                                          height: 15,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "اضغط لاضافة الصور",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onClickEvent: () {
                                    showModalBottomSheet<List<XFile>?>(
                                      context: context,
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(14.0),
                                        ),
                                      ),
                                      builder: (ctx) {
                                        return const ChooseSourceFilesBottomSheet();
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          for (var element in value) {
                                            _images.add(element.path);
                                          }
                                        });
                                      }
                                    });
                                  },
                                  backgroundColor: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomTextField(
                                textInputType: TextInputType.text,
                                controller: _productNameController,
                                hint: "اسم المنتج",
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _productNameController,
                              builder: (context, TextEditingValue value, __) {
                                if (value.text.isNotEmpty) {
                                  _isValidProductName = true;
                                } else {
                                  _isValidProductName = false;
                                }
                                if (_isSubmitted && !_isValidProductName) {
                                  return Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 3, start: 16),
                                      child: Text(
                                        "اسم المنتج مطلوب",
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomTextField(
                                textInputType: TextInputType.text,
                                controller: _storeNameController,
                                hint: "اسم المتجر",
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _storeNameController,
                              builder: (context, TextEditingValue value, __) {
                                if (value.text.isNotEmpty) {
                                  _isValidStoreName = true;
                                } else {
                                  _isValidStoreName = false;
                                }
                                if (_isSubmitted && !_isValidStoreName) {
                                  return Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 3, start: 16),
                                      child: Text(
                                        "اسم المتجر مطلوب",
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomTextField(
                                textInputType: TextInputType.number,
                                controller: _priceController,
                                hint: "السعر",
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _priceController,
                              builder: (context, TextEditingValue value, __) {
                                if (value.text.isNotEmpty) {
                                  _isValidPrice = true;
                                } else {
                                  _isValidPrice = false;
                                }
                                if (_isSubmitted && !_isValidPrice) {
                                  return Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 3, start: 16),
                                      child: Text(
                                        "سعر المنتج مطلوب",
                                        style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "اسم التصنيف",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.basicBlack,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<SelectModel>(
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(
                                          "اسم التصنيف",
                                          style: TextStyle(
                                              color: AppColors.blue,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                      ),
                                      items: _categories.map(
                                        (val) {
                                          return DropdownMenuItem<SelectModel>(
                                            value: val,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text(val.value,
                                                  style: TextStyle(
                                                      color: AppColors.basicBlack,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 16)),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      value: _selectedCategory,
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            _selectedCategory = val;
                                          },
                                        );
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(14),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.border,
                                          ),
                                        ),
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.blue,
                                            ),
                                          ),
                                          margin: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColors.blue,
                                            size: 20,
                                          ),
                                        ),
                                        iconSize: 30,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                        ),
                                        maxHeight: 140,
                                        offset: const Offset(0, 200),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 60,
                                child: CustomButton(
                                  disableBorder: true,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "اضافه المنتج",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onClickEvent: () {
                                    if (_isValidPrice &&
                                        _isValidProductName &&
                                        _isValidStoreName &&
                                        _images.isNotEmpty &&
                                        _selectedCategory != null) {
                                      BlocProvider.of<ProductsCubit>(context)
                                          .addProduct(
                                        ProductParams(
                                          productName:
                                              _productNameController.text,
                                          storeName: _storeNameController.text,
                                          price: double.parse(
                                              _priceController.text),
                                          category:
                                              int.parse(_selectedCategory!.id),
                                          images: _images,
                                        ),
                                      );
                                    } else {
                                      if (!_isSubmitted) {
                                        setState(() {
                                          _isSubmitted = true;
                                        });
                                      }
                                      if (_images.isEmpty) {
                                        Constants.showToast(
                                          context: context,
                                          msg: "يجب ادخال صور المنتج",
                                          color: AppColors.red,
                                          gravity: ToastGravity.SNACKBAR,
                                        );
                                        return;
                                      }
                                      if (_selectedCategory == null) {
                                        Constants.showToast(
                                          context: context,
                                          msg: "يجب اختيار الصنف",
                                          color: AppColors.red,
                                          gravity: ToastGravity.SNACKBAR,
                                        );
                                        return;
                                      }
                                    }
                                  },
                                  backgroundColor: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
          ),
        );
      }),
    );
  }
}
