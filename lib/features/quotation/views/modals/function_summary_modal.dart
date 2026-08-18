import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';

class FunctionSummaryModal extends StatelessWidget {
  const FunctionSummaryModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FunctionSummaryModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final functions = [
      {'num': '01', 'name': AppStrings.haldiDecoration, 'amount': AppStrings.haldiDecorationAmount},
      {'num': '02', 'name': AppStrings.receptionGala, 'amount': AppStrings.receptionGalaAmount},
      {'num': '03', 'name': 'Mehendi', 'amount': AppStrings.mehendiAmount},
      {'num': '04', 'name': 'Wedding Ceremony', 'amount': AppStrings.weddingCeremonyAmount},
      {'num': '05', 'name': 'Logistics & Transport', 'amount': AppStrings.logisticsTransportAmount},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        top: AppDimens.paddingSm,
        left: AppDimens.paddingLg,
        right: AppDimens.paddingLg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppDimens.paddingLg,
      ),
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

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.functionSummary,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    AppStrings.functionSummarySubtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
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

          // Function list items
          ...functions.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: AppDimens.paddingSm),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingMd,
                vertical: AppDimens.paddingMd,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item['num']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimens.paddingMd),
                  Expanded(
                    child: Text(
                      item['name']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    item['amount']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: AppDimens.paddingMd),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppDimens.paddingMd),

          // Total amount footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.totalAmount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                AppStrings.sampleFunctionSummaryGrand,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimens.paddingXl),

          // Close button
          AppButton(
            text: AppStrings.close,
            onPressed: () => Get.back(),
            borderRadius: AppDimens.radiusMd,
          ),
        ],
      ),
    );
  }
}
