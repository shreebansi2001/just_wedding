import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../controllers/create_rsvp_controller.dart';
import 'rsvp_stepper.dart';

class Step1RsvpDetailsView extends GetView<CreateRsvpController> {
  const Step1RsvpDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.rsvpDetails,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.rsvpDetailsSubtitle,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppDimens.paddingLg),
        const RsvpStepper(currentStep: 4),
        const SizedBox(height: AppDimens.paddingLg),
        _buildPartyToggle(),
        const SizedBox(height: AppDimens.paddingLg),
        _buildEventInfoCard(),
        const SizedBox(height: AppDimens.paddingLg),
        _buildLocationCard(),
        const SizedBox(height: AppDimens.paddingLg),
        _buildEventImageryCard(),
        const SizedBox(height: AppDimens.paddingXxl),
        _buildBottomButtons(),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildPartyToggle() {
    return Obx(() {
      final isGroom = controller.selectedParty.value == 'Groom';
      return Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setParty('Groom'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isGroom ? AppColors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isGroom
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    AppStrings.groom,
                    style: GoogleFonts.publicSans(
                      color: isGroom ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isGroom ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setParty('Bride'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !isGroom ? AppColors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: !isGroom
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    AppStrings.bride,
                    style: GoogleFonts.publicSans(
                      color: !isGroom ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: !isGroom ? FontWeight.w700 : FontWeight.w500,
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

  Widget _buildEventInfoCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              Text(
                AppStrings.eventInformation,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.venueName),
          const AppTextField(
            hintText: 'Search or select a venue',
            prefixIcon: Icon(
              Icons.search,
              size: 18,
              color: AppColors.hint,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.weddingDate),
          const AppTextField(
            hintText: 'mm/dd/yyyy',
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.hint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              Text(
                AppStrings.locationLogistics,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.streetAddress),
          const AppTextField(hintText: '123 Main St, Suite 100'),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.city),
                    const AppTextField(hintText: 'New York'),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.country),
                    const AppTextField(
                      hintText: 'United States',
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.hint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          // Advanced Location Dropdown
          Obx(() {
            final isOpen = controller.isAdvancedLocationOpen.value;
            return GestureDetector(
              onTap: controller.toggleAdvancedLocation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Advanced Location (Lat/Long)',
                      style: GoogleFonts.publicSans(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: AppColors.hint,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEventImageryCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.photo_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              Text(
                AppStrings.eventImagery,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryTint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppStrings.ratio169,
                  style: GoogleFonts.publicSans(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.eventImageryDesc,
            style: GoogleFonts.publicSans(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              // Add Photo Box
              Container(
                width: 90,
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  border: Border.all(
                    color: AppColors.border,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.hint,
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.addPhoto,
                      style: GoogleFonts.publicSans(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              // Sample uploaded thumbnail with X close button
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 75,
                    decoration: BoxDecoration(
                      color: AppColors.primaryTint,
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=200&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 11,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
            text: AppStrings.saveDraft,
            isOutlined: true,
            hasShadow: false,
            textColor: AppColors.textPrimary,
            backgroundColor: AppColors.border,
            onPressed: controller.saveDraft,
            borderRadius: AppDimens.radiusMd,
            height: 48,
          ),
        ),
        const SizedBox(width: AppDimens.paddingMd),
        Expanded(
          flex: 1,
          child: AppButton(
            text: 'Next Step',
            onPressed: controller.nextStep,
            borderRadius: AppDimens.radiusMd,
            height: 48,
            hasShadow: true,
            icon: const Icon(
              Icons.arrow_forward,
              color: AppColors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}

