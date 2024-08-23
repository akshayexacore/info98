import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_round_button.dart';

class AppDialog {
  static showDialog({
    String? title,
    String? content,
    String? positiveText,
    String? negativeText,
    VoidCallback? positiveOnPressed,
    VoidCallback? negativeOnPressed,
    bool dismissible = false,
  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.medium),
          ),
          child: Container(
            width: AppSizes.alertDialog,
            padding: const EdgeInsets.all(AppPaddings.alertDialog),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: AppTextStyles.alertDialogTitle,
                    textAlign: TextAlign.center,
                  ),
                if (content != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: AppSpacings.medium,
                      ),
                      Text(
                        content,
                        style: AppTextStyles.alertDialogContent,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                if (negativeText != null || positiveText != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: AppSpacings.medium,
                      ),
                      Row(
                        children: [
                          if (negativeText != null)
                            Expanded(
                              child: AppRoundButton(
                                text: negativeText,
                                onPressed: negativeOnPressed,
                                style: AppButtonStyles.alertDialogNegative,
                                height: AppSizes.dialogButtonHeight,
                                textStyle: AppTextStyles.appButton
                                    .copyWith(color: AppColors.textSubtitle),
                              ),
                            ),
                          if (positiveText != null && negativeText != null)
                            const SizedBox(
                              width: AppSpacings.xSmall,
                            ),
                          if (positiveText != null)
                            Expanded(
                              child: AppRoundButton(
                                text: positiveText,
                                onPressed: positiveOnPressed,
                                style: AppButtonStyles.alertDialogPositive,
                                height: AppSizes.dialogButtonHeight,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        barrierDismissible: dismissible);
  }

  static showSnackBar(String title, String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.black,
      margin: const EdgeInsets.all(0),
      colorText: AppColors.white,
      borderRadius: 0.0,
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
