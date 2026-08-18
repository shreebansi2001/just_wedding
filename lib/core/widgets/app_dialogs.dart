import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import 'app_button.dart';

class AppDialogs {
  AppDialogs._();

  static void showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      contentPadding: const EdgeInsets.all(AppDimens.paddingMd),
      titlePadding: const EdgeInsets.only(top: AppDimens.paddingLg, bottom: AppDimens.paddingSm),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
      confirm: AppButton(
        text: confirmText,
        onPressed: () {
          Get.back();
          onConfirm();
        },
        width: 120,
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          cancelText,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      radius: AppDimens.radiusMd,
      backgroundColor: AppColors.white,
    );
  }

  static void showLoadingDialog() {
    Get.dialog(
      const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
