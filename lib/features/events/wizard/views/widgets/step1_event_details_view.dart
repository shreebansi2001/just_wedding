import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                _buildLabel(AppStrings.eventType),
                Obx(() => AppTextField(
                  hintText: controller.eventTypeController.text.isEmpty ? 'Select Event Type' : controller.eventTypeController.text,
                  readOnly: true,
                  suffixIcon: controller.isEventTypesLoading.value 
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                        )
                      : const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                  onTap: () {
                    if (controller.eventTypes.isEmpty) return;
                    Get.bottomSheet(
                      Container(
                        color: AppColors.white,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.eventTypes.length,
                          itemBuilder: (context, index) {
                            final type = controller.eventTypes[index];
                            return ListTile(
                              title: Text(type.nameEnglish ?? ''),
                              onTap: () {
                                controller.eventTypeId.value = type.id;
                                controller.eventTypeController.text = type.nameEnglish ?? '';
                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                )),
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
                            suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
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
                          prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
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
                          prefixIcon: const Icon(Icons.access_time, size: 18, color: AppColors.textSecondary),
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
                          prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
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
                          prefixIcon: const Icon(Icons.access_time, size: 18, color: AppColors.textSecondary),
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
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('₹', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
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
                prefixIcon: const Icon(Icons.location_on_outlined, size: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimens.paddingMd),
              _buildLabel(AppStrings.specialInstructions),
              AppTextField(
                hintText: AppStrings.specialInstructionsHint,
                controller: controller.remarksController,
                maxLines: 4,
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
                onPressed: controller.cancel,
                borderRadius: AppDimens.radiusMd,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            Expanded(
              flex: 2,
              child: AppButton(
                text: AppStrings.continueToClient,
                onPressed: controller.nextStep,
                borderRadius: AppDimens.radiusMd,
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
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
