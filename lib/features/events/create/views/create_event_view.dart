import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/create_event_controller.dart';

class CreateEventView extends GetView<CreateEventController> {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppDimens.paddingXxl),
                  _buildLabel(AppStrings.eventName),
                  const SizedBox(height: AppDimens.paddingSm),
                  const AppTextField(
                    hintText: AppStrings.eventNameHint,
                    prefixIcon: Icon(Icons.edit_outlined, color: AppColors.primary),
                  ),
                  const SizedBox(height: AppDimens.paddingXxl),
                  _buildLabel(AppStrings.eventType),
                  const SizedBox(height: AppDimens.paddingMd),
                  _buildEventTypeGrid(),
                  const SizedBox(height: AppDimens.paddingXxl),
                  _buildLabel(AppStrings.eventDate),
                  const SizedBox(height: AppDimens.paddingSm),
                  const AppTextField(
                    hintText: 'mm/dd/yyyy',
                    suffixIcon: Icon(Icons.calendar_today_outlined, color: AppColors.hint),
                  ),
                  const SizedBox(height: AppDimens.paddingXxl),
                  _buildLabel(AppStrings.priority),
                  const SizedBox(height: AppDimens.paddingSm),
                  _buildPrioritySegmentedControl(),
                  const SizedBox(height: AppDimens.paddingXxl),
                  AppButton(
                    text: AppStrings.continueArrow,
                    onPressed: controller.continueToNextStep,
                    borderRadius: AppDimens.radiusFull,
                    height: AppDimens.buttonHeightLg,
                    icon: const Icon(Icons.arrow_forward, color: AppColors.white, size: 18),
                  ),
                  const SizedBox(height: AppDimens.paddingXxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.createEventTitle,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppDimens.paddingXs),
              const Text(
                AppStrings.createEventSubtitle,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withAlpha(128),
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
          ),
          child: const Icon(Icons.event_available, color: AppColors.primary, size: 40),
        ),
      ],
    );
  }

  Widget _buildEventTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimens.paddingMd,
        mainAxisSpacing: AppDimens.paddingMd,
        childAspectRatio: 1.0,
      ),
      itemCount: controller.eventTypes.length,
      itemBuilder: (context, index) {
        final item = controller.eventTypes[index];
        final name = item['name']!;
        final icon = item['icon']!;

        return Obx(() {
          final isSelected = controller.eventType.value == name;
          return GestureDetector(
            onTap: () => controller.selectType(name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : AppColors.white,
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: AppDimens.paddingSm),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildPrioritySegmentedControl() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withAlpha(100),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Obx(() {
        return Row(
          children: controller.priorities.map((p) {
            final isSelected = controller.priority.value == p;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectPriority(p),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  ),
                  child: Text(
                    p,
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
