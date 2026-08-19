import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final Widget? icon;
  final double? borderRadius;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
    this.icon,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppDimens.radiusSm;
    final btnHeight = height ?? AppDimens.buttonHeight;

    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: btnHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppColors.primary,
            side: BorderSide(color: backgroundColor ?? AppColors.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2.0,
                  ),
                )
              : _buildContent(textColor ?? AppColors.primary),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.0,
                ),
              )
            : _buildContent(textColor ?? AppColors.white),
      ),
    );
  }

  Widget _buildContent(Color color) {
    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(
            text,
            style: textStyle,
          ),
        ],
      );
    }

    return Text(
      text,
      style: textStyle,
    );
  }
}
