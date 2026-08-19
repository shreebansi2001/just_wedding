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

class Step1EventDetailsView extends GetView<EventWizardController> {
  const Step1EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WizardProgressBar(
          currentStep: 1,
          totalSteps: 4,
          title: AppStrings.eventDetails,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        _buildSectionCard(
          title: AppStrings.basicInformation,
          child: Form(
            key: controller.formKeyStep1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLabel(AppStrings.clientId),
                AppTextField(
                  hintText: AppStrings.clientIdHint,
                  readOnly: true,
                  controller: TextEditingController(text: controller.clientId.value),
                ),
                const SizedBox(height: AppDimens.paddingMd),
                _buildLabel(AppStrings.eventNameRequired),
                AppTextField(
                  hintText: AppStrings.eventNameWizardHint,
                  controller: controller.eventNameController,
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: AppDimens.paddingMd),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel(AppStrings.inquiryDate),
                          AppTextField(
                            hintText: 'mm/dd/yyyy',
                            controller: controller.inquiryDateController,
                            readOnly: true,
                            onTap: () => controller.selectDate(context, controller.inquiryDateController),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimens.paddingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel(AppStrings.status),
                          AppTextField(
                            hintText: AppStrings.statusPlanning,
                            controller: controller.statusController,
                            readOnly: true,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimens.paddingLg),
        _buildSectionCard(
          title: AppStrings.eventSchedule,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(AppStrings.startDate),
                        AppTextField(
                          hintText: 'mm/dd/yyyy',
                          controller: controller.startDateController,
                          readOnly: true,
                          onTap: () => controller.selectDate(context, controller.startDateController),
                          prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.hint),
                          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimens.paddingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(AppStrings.startTime),
                        AppTextField(
                          hintText: '--:-- --',
                          controller: controller.startTimeController,
                          readOnly: true,
                          onTap: () => controller.selectTime(context, controller.startTimeController),
                          prefixIcon: const Icon(Icons.access_time, size: 18, color: AppColors.hint),
                          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.paddingMd),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(AppStrings.endDate),
                        AppTextField(
                          hintText: 'mm/dd/yyyy',
                          controller: controller.endDateController,
                          readOnly: true,
                          onTap: () => controller.selectDate(context, controller.endDateController),
                          prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.hint),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimens.paddingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(AppStrings.endTime),
                        AppTextField(
                          hintText: '--:-- --',
                          controller: controller.endTimeController,
                          readOnly: true,
                          onTap: () => controller.selectTime(context, controller.endTimeController),
                          prefixIcon: const Icon(Icons.access_time, size: 18, color: AppColors.hint),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.paddingLg),
        _buildSectionCard(
          title: AppStrings.budgetInformation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabel(AppStrings.estimatedBudget),
              AppTextField(
                hintText: '0.00',
                controller: controller.estimatedBudgetController,
                keyboardType: TextInputType.number,
                prefixIcon: Container(
                  width: 32,
                  alignment: Alignment.center,
                  child: Text('₹', style: GoogleFonts.publicSans(fontSize: 16, color: AppColors.hint)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.paddingLg),
        _buildSectionCard(
          title: AppStrings.venueDetails,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabel(AppStrings.preferredVenue),
              AppTextField(
                hintText: AppStrings.preferredVenueHint,
                controller: controller.preferredVenueController,
                prefixIcon: const Icon(Icons.location_on_outlined, size: 18, color: AppColors.hint),
                suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
              ),
              const SizedBox(height: AppDimens.paddingMd),
              _buildLabel(AppStrings.specialInstructions),
              AppTextField(
                hintText: AppStrings.specialInstructionsHint,
                controller: controller.remarksController,
                maxLines: 3,
              ),
            ],
          ),
        ),
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
                onPressed: controller.cancel,
                borderRadius: AppDimens.radiusMd,
                height: 48,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            Expanded(
              flex: 2,
              child: AppButton(
                text: AppStrings.continueToClient,
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

  Widget _buildSectionCard({required String title, required Widget child}) {
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
            title,
            style: GoogleFonts.publicSans(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          child,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
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
}

