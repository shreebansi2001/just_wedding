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

class Step4OtherDetailsView extends GetView<EventWizardController> {
  const Step4OtherDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WizardProgressBar(
          currentStep: 4,
          totalSteps: 4,
          title: AppStrings.otherDetails,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        _buildSegmentedTabs(),
        const SizedBox(height: AppDimens.paddingLg),
        Obx(() {
          if (controller.selectedOtherTab.value == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPersonInfoCard(
                  title: AppStrings.groomsInformation,
                ),
                const SizedBox(height: AppDimens.paddingLg),
                _buildPersonInfoCard(
                  title: AppStrings.bridesInformation,
                ),
              ],
            );
          } else {
            return _buildOtherReferenceCard();
          }
        }),
        const SizedBox(height: AppDimens.paddingXxl),
        _buildBottomButtons(),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildSegmentedTabs() {
    return Obx(() {
      final isGroomBride = controller.selectedOtherTab.value == 0;
      return Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setOtherTab(0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isGroomBride ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isGroomBride
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    AppStrings.groomBride,
                    style: GoogleFonts.publicSans(
                      color: isGroomBride ? AppColors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setOtherTab(1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isGroomBride ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: !isGroomBride
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    AppStrings.otherReference,
                    style: GoogleFonts.publicSans(
                      color: !isGroomBride ? AppColors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPersonInfoCard({required String title}) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              Text(
                title,
                style: GoogleFonts.publicSans(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.name),
          const AppTextField(hintText: AppStrings.enterFullName),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.fathersName),
          const AppTextField(hintText: AppStrings.enterFathersName),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.contactNumber),
          const AppTextField(
            hintText: '+1 (555) 000-0000',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.instaId),
          AppTextField(
            hintText: 'username',
            prefixIcon: Container(
              alignment: Alignment.center,
              width: 36,
              child: const Icon(Icons.alternate_email, size: 16, color: AppColors.hint),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.birthdate),
          const AppTextField(
            hintText: 'mm/dd/yyyy',
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.hint,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.photographerName),
          const AppTextField(hintText: 'Name of studio or person'),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.contactNumber),
          const AppTextField(
            hintText: '+1 (555) 000-0000',
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildOtherReferenceCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.assignedPhotographer,
            style: GoogleFonts.publicSans(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.photographerName),
          const AppTextField(hintText: 'Name of studio or person'),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.contactNumber),
          const AppTextField(
            hintText: '+1 (555) 000-0000',
            keyboardType: TextInputType.phone,
          ),
        ],
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

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AppButton(
            text: AppStrings.back,
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
          flex: 1,
          child: Obx(() => AppButton(
            text: AppStrings.complete,
            onPressed: controller.completeWizard,
            isLoading: controller.isLoading.value,
            borderRadius: AppDimens.radiusMd,
            height: 48,
            hasShadow: true,
          )),
        ),
      ],
    );
  }
}

