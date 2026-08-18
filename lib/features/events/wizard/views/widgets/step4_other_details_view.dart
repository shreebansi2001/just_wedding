import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        padding: const EdgeInsets.all(AppDimens.paddingXs),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setOtherTab(0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isGroomBride ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                    boxShadow: isGroomBride
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(50),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    AppStrings.groomBride,
                    style: TextStyle(
                      color: isGroomBride ? AppColors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isGroomBride ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                    boxShadow: !isGroomBride
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(50),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    AppStrings.otherReference,
                    style: TextStyle(
                      color: !isGroomBride ? AppColors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
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
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingLg),
          _buildFieldLabel(AppStrings.name),
          const AppTextField(hintText: AppStrings.enterFullName),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.fathersName),
          const AppTextField(hintText: AppStrings.enterFathersName),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.contactNumber),
          const AppTextField(
            hintText: AppStrings.phonePlaceholder,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.instaId),
          AppTextField(
            hintText: AppStrings.usernamePlaceholder,
            prefixIcon: Container(
              alignment: Alignment.center,
              width: 36,
              child: const Text(
                '@',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.birthdate),
          const AppTextField(
            hintText: 'mm/dd/yyyy',
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.photographerName),
          const AppTextField(hintText: AppStrings.photographerPlaceholder),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.contactNumber),
          const AppTextField(
            hintText: AppStrings.phonePlaceholder,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildOtherReferenceCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            AppStrings.assignedPhotographer,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimens.paddingLg),
          _buildFieldLabel(AppStrings.photographerName),
          const AppTextField(hintText: AppStrings.photographerPlaceholder),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.contactNumber),
          const AppTextField(
            hintText: AppStrings.phonePlaceholder,
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
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
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
            onPressed: controller.previousStep,
            borderRadius: AppDimens.radiusMd,
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
          )),
        ),
      ],
    );
  }
}
