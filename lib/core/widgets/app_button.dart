import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

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
  final bool hasShadow;

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
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppDimens.radiusLg;
    final btnHeight = height ?? AppDimens.buttonHeightLg;
    final bgColor = backgroundColor ?? AppColors.primary;
    final fgColor = textColor ?? (isOutlined ? AppColors.primary : AppColors.white);

    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: btnHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: fgColor,
            side: BorderSide(color: bgColor, width: 1.5),
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
              : _buildContent(fgColor),
        ),
      );
    }

    return Container(
      width: width ?? double.infinity,
      height: btnHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: (hasShadow && !isLoading)
            ? [
                BoxShadow(
                  color: AppColors.primaryShadow,
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                  spreadRadius: -6,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : _buildContent(fgColor),
      ),
    );
  }

  Widget _buildContent(Color color) {
    final textWidget = Text(
      text,
      style: GoogleFonts.publicSans(
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textWidget,
          const SizedBox(width: 8),
          icon!,
        ],
      );
    }

    return textWidget;
  }
}

