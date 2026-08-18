import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';

class QuotationUpdateHistoryModal extends StatelessWidget {
  const QuotationUpdateHistoryModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuotationUpdateHistoryModal(),
    );
  }

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

          // Header with close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.quotationUpdateHistory,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      AppStrings.quotationHistorySubtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
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
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppDimens.paddingLg),

          // Timeline items
          _buildTimelineItem(
            initials: 'JD',
            name: 'Jane Doe',
            time: '10:00 AM',
            tag: 'Update Logistics',
            tagColor: const Color(0xFFFDE8E8),
            tagTextColor: AppColors.primary,
            date: 'Oct 25, 2024',
            message: 'Updated transportation and lighting requirements for the main hall.',
            isLast: false,
            hasBorderInitial: true,
          ),
          _buildTimelineItem(
            initials: 'MS',
            name: 'Marc Smith',
            time: '02:30 PM',
            tag: 'Structural Review',
            tagColor: const Color(0xFFE5E7EB),
            tagTextColor: AppColors.textPrimary,
            date: 'Oct 24, 2024',
            message: 'Reviewed stage stability and load-bearing capacity for the crystal cascade.',
            isLast: false,
            hasBorderInitial: false,
          ),
          _buildTimelineItem(
            initials: 'AR',
            name: 'Alice Rogers',
            time: '09:15 AM',
            tag: 'Creation',
            tagColor: const Color(0xFFE5E7EB),
            tagTextColor: AppColors.textPrimary,
            date: 'Oct 22, 2024',
            message: null,
            isLast: true,
            hasBorderInitial: false,
          ),

          const SizedBox(height: AppDimens.paddingXl),

          // Bottom actions
          AppButton(
            text: AppStrings.downloadLogPdf,
            onPressed: () => Get.back(),
            borderRadius: AppDimens.radiusMd,
            icon: const Icon(Icons.download_outlined, color: AppColors.white, size: 18),
          ),
          const SizedBox(height: AppDimens.paddingSm),
          AppButton(
            text: AppStrings.closeDetails,
            isOutlined: true,
            onPressed: () => Get.back(),
            borderRadius: AppDimens.radiusMd,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String initials,
    required String name,
    required String time,
    required String tag,
    required Color tagColor,
    required Color tagTextColor,
    required String date,
    required String? message,
    required bool isLast,
    required bool hasBorderInitial,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left timeline column
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasBorderInitial ? AppColors.white : const Color(0xFFF3F4F6),
                  border: hasBorderInitial
                      ? Border.all(color: AppColors.primary, width: 2)
                      : null,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: hasBorderInitial ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppDimens.paddingMd),

          // Right content column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: tagColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: tagTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(AppDimens.paddingMd),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
