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
    return Form(
      key: controller.formKeyStep1,
      child: Column(
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
                          _buildLabel('Inquiry Date'),
                          AppTextField(
                            hintText: 'dd/mm/yyyy',
                            controller: controller.inquiryDateController,
                            readOnly: true,
                            onTap: () => controller.selectDate(
                              context,
                              controller.inquiryDateController,
                            ),
                            suffixIcon: const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: AppColors.hint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimens.paddingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildLabel('Event Type *'),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  '+ Add New',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton<int>(
                            onSelected: (id) {
                              final type = controller.eventTypes
                                  .firstWhereOrNull((e) => e.id == id);
                              if (type != null) {
                                controller.eventTypeId.value = type.id;
                                controller.eventTypeController.text =
                                    type.nameEnglish ?? '';
                              }
                            },
                            itemBuilder: (context) => controller.eventTypes
                                .map(
                                  (t) => PopupMenuItem(
                                    value: t.id,
                                    child: Text(t.nameEnglish ?? ''),
                                  ),
                                )
                                .toList(),
                            child: IgnorePointer(
                              child: AppTextField(
                                controller: controller.eventTypeController,
                                hintText: 'Select Event Type',
                                readOnly: true,
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.hint,
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Required'
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.paddingMd),
                _buildLabel('Event Status *'),
                PopupMenuButton<String>(
                  onSelected: (status) {
                    controller.statusController.text = status;
                  },
                  itemBuilder: (context) => controller.statusOptions
                      .map((s) => PopupMenuItem(value: s, child: Text(s)))
                      .toList(),
                  child: IgnorePointer(
                    child: AppTextField(
                      controller: controller.statusController,
                      hintText: 'Select Status',
                      readOnly: true,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.hint,
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                ),
              ],
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
                            onTap: () => controller.selectDate(
                              context,
                              controller.startDateController,
                            ),
                            prefixIcon: const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: AppColors.hint,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
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
                            onTap: () => controller.selectTime(
                              context,
                              controller.startTimeController,
                            ),
                            prefixIcon: const Icon(
                              Icons.access_time,
                              size: 18,
                              color: AppColors.hint,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
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
                            onTap: () => controller.selectDate(
                              context,
                              controller.endDateController,
                            ),
                            prefixIcon: const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: AppColors.hint,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
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
                            onTap: () => controller.selectTime(
                              context,
                              controller.endTimeController,
                            ),
                            prefixIcon: const Icon(
                              Icons.access_time,
                              size: 18,
                              color: AppColors.hint,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
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
                    child: Text(
                      '₹',
                      style: GoogleFonts.publicSans(
                        fontSize: 16,
                        color: AppColors.hint,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.paddingLg),
          _buildSectionCard(
            title: 'VENUE INFORMATION',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLabel('Venue *'),
                PopupMenuButton<int>(
                  onSelected: (id) {
                    final v = controller.venues.firstWhereOrNull(
                      (e) => e.id == id,
                    );
                    if (v != null) {
                      controller.selectedVenueId.value = v.id;
                      controller.preferredVenueController.text =
                          v.nameEnglish ?? '';
                    }
                  },
                  itemBuilder: (context) => controller.venues
                      .map(
                        (v) => PopupMenuItem(
                          value: v.id,
                          child: Text(v.nameEnglish ?? ''),
                        ),
                      )
                      .toList(),
                  child: IgnorePointer(
                    child: AppTextField(
                      controller: controller.preferredVenueController,
                      hintText: 'Search or select a venue...',
                      readOnly: true,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.hint,
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
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
      ),
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
