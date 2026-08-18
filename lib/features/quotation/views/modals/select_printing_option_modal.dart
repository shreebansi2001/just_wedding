import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';

class SelectPrintingOptionModal extends StatefulWidget {
  const SelectPrintingOptionModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SelectPrintingOptionModal(),
    );
  }

  @override
  State<SelectPrintingOptionModal> createState() => _SelectPrintingOptionModalState();
}

class _SelectPrintingOptionModalState extends State<SelectPrintingOptionModal> {
  int selectedOption = 0; // 0 for Event Wise, 1 for Function Wise

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Header with close icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.selectPrintingOption,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                onPressed: () => Get.back(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingLg),

          // Option 1: Event Wise
          _buildOptionCard(
            index: 0,
            icon: Icons.description_outlined,
            title: AppStrings.eventWise,
            description: AppStrings.eventWiseDesc,
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Option 2: Function Wise
          _buildOptionCard(
            index: 1,
            icon: Icons.menu_book_outlined,
            title: AppStrings.functionWise,
            description: AppStrings.functionWiseDesc,
          ),
          const SizedBox(height: AppDimens.paddingXl),

          // Bottom Buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: AppStrings.cancel,
                  isOutlined: true,
                  onPressed: () => Get.back(),
                  borderRadius: AppDimens.radiusMd,
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: AppButton(
                  text: AppStrings.print,
                  onPressed: () => Get.back(),
                  borderRadius: AppDimens.radiusMd,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingSm),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required int index,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = selectedOption == index;
    return GestureDetector(
      onTap: () => setState(() => selectedOption = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppDimens.paddingMd),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimens.paddingSm),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : const Color(0xFFD1D5DB),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
