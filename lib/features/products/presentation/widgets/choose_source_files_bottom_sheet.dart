import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jacksi_ltd/core/utils/extensions.dart';
import '../../../../core/utils/app_colors.dart';

class ChooseSourceFilesBottomSheet extends StatefulWidget {
  const ChooseSourceFilesBottomSheet({super.key});

  @override
  State<ChooseSourceFilesBottomSheet> createState() =>
      _ChooseSourceFilesBottomSheetState();
}

class _ChooseSourceFilesBottomSheetState
    extends State<ChooseSourceFilesBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: 160,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 4,
              width: context.width * 0.3,
              color: AppColors.grey,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage(1, context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text(
                              "من الكميرا",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.basicBlack,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.camera_alt,
                            size: 25,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImage(2, context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.getResponsiveSize(5)),
                            child: Text(
                              "من المعرض",
                              style: TextStyle(
                                fontSize: context.getResponsiveSize(16),
                                fontWeight: FontWeight.w600,
                                color: AppColors.basicBlack,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.getResponsiveSize(5),
                          ),
                          Icon(
                            Icons.image,
                            size: context.getResponsiveSize(25),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectImage(int type, BuildContext context) {
    try {
      ImagePicker picker = ImagePicker();

      type == 1
          ? picker.pickImage(source: ImageSource.camera).then(
              (value) async {
                if (value != null) {
                  Navigator.pop(context, [value]);
                } else {
                  Navigator.pop(context);
                }
              },
            )
          : picker.pickMultiImage().then(
              (value) async {
                if (value.isNotEmpty) {
                  Navigator.pop(context, value);
                } else {
                  Navigator.pop(context);
                }
              },
            );
    } catch (e) {
      return;
    }
  }
}
