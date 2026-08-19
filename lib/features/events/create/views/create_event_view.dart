import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          icon: const Icon(Icons.arrow_back, color: AppColors.primary, size: 22),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppDimens.paddingLg),
                  _buildLabel(AppStrings.eventName),
                  const SizedBox(height: AppDimens.paddingSm),
                  AppTextField(
                    hintText: AppStrings.eventNameHint,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Text('🪄', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: AppDimens.paddingLg),
                  _buildLabel(AppStrings.eventType),
                  const SizedBox(height: AppDimens.paddingSm),
                  _buildEventTypeGrid(),
                  const SizedBox(height: AppDimens.paddingLg),
                  _buildLabel(AppStrings.eventDate),
                  const SizedBox(height: AppDimens.paddingSm),
                  const AppTextField(
                    hintText: 'mm/dd/yyyy',
                    suffixIcon: Icon(Icons.calendar_today_outlined, color: AppColors.hint, size: 20),
                  ),
                  const SizedBox(height: AppDimens.paddingLg),
                  _buildLabel(AppStrings.priority),
                  const SizedBox(height: AppDimens.paddingSm),
                  _buildPrioritySegmentedControl(),
                  const SizedBox(height: AppDimens.paddingXl),
                  AppButton(
                    text: 'Continue',
                    onPressed: controller.continueToNextStep,
                    borderRadius: AppDimens.radiusLg,
                    height: 56,
                    hasShadow: true,
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
      style: GoogleFonts.publicSans(
        color: AppColors.textPrimary,
        fontSize: 14,
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
              Text(
                AppStrings.createEventTitle,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.createEventSubtitle,
                style: GoogleFonts.publicSans(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        _buildHeaderIllustration(),
      ],
    );
  }

  Widget _buildHeaderIllustration() {
    return Container(
      width: 90,
      height: 75,
      padding: const EdgeInsets.all(6),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Clipboard back
          Positioned(
            left: 20,
            top: 5,
            child: Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFDE8EF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFF4B8CD), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 18,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(3, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, size: 5, color: Colors.white),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Small plant on left
          Positioned(
            left: 2,
            bottom: 6,
            child: Container(
              width: 18,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFFCE7F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.spa, size: 14, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.05,
      ),
      itemCount: controller.eventTypes.length,
      itemBuilder: (context, index) {
        final item = controller.eventTypes[index];
        final name = item.nameEnglish ?? 'Unknown';
        final icon = '🗓️'; // Placeholder since imgPath requires network image

        return Obx(() {
          final isSelected = controller.selectedEventTypeId.value == item.id;
          return GestureDetector(
            onTap: () => controller.selectType(item.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryTint.withValues(alpha: 0.6) : AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: isSelected ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    icon,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.publicSans(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Obx(() {
        final prioritiesList = ['High', 'Med', 'Low'];
        return Row(
          children: prioritiesList.map((p) {
            final isSelected = controller.selectedPriority.value == p;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.setPriority(p),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    p,
                    style: GoogleFonts.publicSans(
                      color: isSelected ? AppColors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
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

