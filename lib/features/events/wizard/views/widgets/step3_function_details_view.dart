import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../controllers/event_wizard_controller.dart';
import 'wizard_progress_bar.dart';

class Step3FunctionDetailsView extends GetView<EventWizardController> {
  const Step3FunctionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WizardProgressBar(
          currentStep: 3,
          totalSteps: 4,
          title: AppStrings.functionDetails,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        const AppTextField(
          hintText: AppStrings.searchFunctions,
          prefixIcon: Icon(Icons.search, color: AppColors.hint, size: 20),
        ),
        const SizedBox(height: AppDimens.paddingMd),
        AppButton(
          text: '+ Add Function',
          onPressed: () {},
          borderRadius: AppDimens.radiusMd,
          height: 48,
          hasShadow: true,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        // Dynamic Function List
        Obx(() => Column(
          children: controller.functions.map((function) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.paddingMd),
              child: _buildFunctionCard(
                name: function.name,
                icon: function.icon,
                iconBgColor: function.iconBgColor,
                iconColor: function.iconColor,
                borderColor: function.borderColor,
                date: function.date,
                time: function.time,
                venue: function.venue,
                subVenue: function.subVenue,
                isFilledData: function.isFilledData,
              ),
            );
          }).toList(),
        )),

        const SizedBox(height: AppDimens.paddingXxl),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: AppButton(
                text: AppStrings.cancel,
                isOutlined: true,
                hasShadow: false,
                textColor: AppColors.primary,
                backgroundColor: AppColors.border,
                onPressed: controller.previousStep,
                borderRadius: AppDimens.radiusMd,
                height: 48,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            Expanded(
              flex: 2,
              child: AppButton(
                text: AppStrings.continueToOther,
                onPressed: controller.nextStep,
                borderRadius: AppDimens.radiusMd,
                height: 48,
                hasShadow: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildFunctionCard({
    required String name,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color borderColor,
    required String? date,
    required String? time,
    required String venue,
    required String subVenue,
    required bool isFilledData,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left colored border accent
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: iconColor, size: 20),
                        ),
                        const SizedBox(width: AppDimens.paddingSm),
                        Expanded(
                          child: Text(
                            name,
                            style: GoogleFonts.publicSans(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.hint),
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.paddingMd),

                    // Date & Time row
                    if (isFilledData) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildIconLabel(Icons.calendar_today_outlined, AppStrings.date),
                                const SizedBox(height: 4),
                                Text(
                                  date ?? '',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildIconLabel(Icons.access_time, AppStrings.time),
                                const SizedBox(height: 4),
                                Text(
                                  time ?? '',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel(AppStrings.date),
                                const AppTextField(
                                  hintText: 'mm/dd/yyyy',
                                  prefixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.hint),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel(AppStrings.time),
                                const AppTextField(
                                  hintText: '--:-- --',
                                  prefixIcon: Icon(Icons.access_time, size: 18, color: AppColors.hint),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppDimens.paddingMd),

                    // Venue
                    _buildIconLabel(Icons.location_on_outlined, AppStrings.venue),
                    const SizedBox(height: 4),
                    AppTextField(
                      hintText: venue,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
                    ),
                    const SizedBox(height: AppDimens.paddingMd),

                    // Sub Venue
                    _buildIconLabel(Icons.door_front_door_outlined, AppStrings.subVenue),
                    const SizedBox(height: 4),
                    AppTextField(
                      hintText: subVenue,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
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

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXs),
      child: Text(
        text,
        style: GoogleFonts.publicSans(
          color: AppColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildIconLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

