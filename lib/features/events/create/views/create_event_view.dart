import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/create_event_controller.dart';
import '../../../../core/utils/responsive.dart';

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
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppDimens.paddingXxl),
                  
                  _buildLabel('PROJECT NAME'),
                  AppTextField(
                    hintText: 'e.g. Rahul & Priya Wedding',
                    controller: controller.eventNameController,
                    prefixIcon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.primary),
                  ),
                  const SizedBox(height: AppDimens.paddingXxl),

                  _buildLabel('EVENT TYPE'),
                  AppTextField(
                    hintText: 'Search event type...',
                    prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.primary),
                    onChanged: controller.onSearchChanged,
                  ),
                  const SizedBox(height: AppDimens.paddingMd),
                  _buildEventTypeGrid(),
                  const SizedBox(height: AppDimens.paddingXxl),

                  _buildLabel('EVENT DATE'),
                  AppTextField(
                    hintText: 'DD/MM/YYYY',
                    controller: controller.eventDateController,
                    readOnly: true,
                    onTap: () => controller.selectDate(context),
                    suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.hint),
                  ),
                  const SizedBox(height: AppDimens.paddingXxl),

                  _buildLabel('PRIORITY'),
                  _buildPriorityToggle(),
                  const SizedBox(height: AppDimens.paddingXxl),

                  AppButton(
                    text: 'Create Event Workspace',
                    onPressed: controller.continueToNextStep,
                    borderRadius: AppDimens.radiusMd,
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

  Widget _buildEventTypeGrid() {
    return Obx(() {
      if (controller.isLoadingTypes.value && controller.eventTypes.isEmpty) {
        return const Center(child: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLg),
          child: CircularProgressIndicator(color: AppColors.primary),
        ));
      }
      
      return ResponsiveBuilder(
        builder: (context, info) {
          int crossAxisCount = info.isMobile ? 2 : 4;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppDimens.paddingMd,
              mainAxisSpacing: AppDimens.paddingMd,
              childAspectRatio: 1.5,
            ),
            itemCount: controller.eventTypes.length,
            itemBuilder: (context, index) {
              final type = controller.eventTypes[index];
              return Obx(() {
                final isSelected = controller.selectedEventTypeId.value == type.id;
                return GestureDetector(
                  onTap: () => controller.selectType(type.id),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(20),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (type.imgPath != null && type.imgPath!.isNotEmpty)
                          Image.network(
                            type.imgPath!,
                            height: 32,
                            width: 32,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.event, color: AppColors.primary),
                          )
                        else
                          const Icon(Icons.event, color: AppColors.primary, size: 32),
                        const SizedBox(height: AppDimens.paddingXs),
                        Text(
                          type.nameEnglish ?? '',
                          style: TextStyle(
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      );
    });
  }

  Widget _buildPriorityToggle() {
    return Obx(() {
      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFDE9E9), // Light pinkish background from screenshot
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        child: Row(
          children: [
            _buildPriorityOption('High'),
            _buildPriorityOption('Med'),
            _buildPriorityOption('Low'),
          ],
        ),
      );
    });
  }

  Widget _buildPriorityOption(String title) {
    final isSelected = controller.selectedPriority.value == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setPriority(title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXs),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start Your Journey',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppDimens.paddingXs),
        const Text(
          'Fill in the core details to initialize your workspace.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
