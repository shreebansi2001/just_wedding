import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../controllers/create_rsvp_controller.dart';
import 'rsvp_stepper.dart';

class Step2GuestDetailsView extends GetView<CreateRsvpController> {
  const Step2GuestDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          AppStrings.guestDetails,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppDimens.paddingXs),
        const Text(
          AppStrings.guestDetailsSubtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppDimens.paddingLg),
        const RsvpStepper(currentStep: 2),
        const SizedBox(height: AppDimens.paddingLg),
        _buildPrimaryGuestCard(),
        const SizedBox(height: AppDimens.paddingLg),
        _buildAdditionalGuestsCard(),
        const SizedBox(height: AppDimens.paddingXxl),
        _buildBottomButtons(),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildPrimaryGuestCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.primaryGuest,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingXs),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              AppStrings.primaryGuestSubtitle,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingLg),
          _buildFieldLabel(AppStrings.fullName),
          const AppTextField(hintText: AppStrings.sampleGuestName),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.emailId),
          const AppTextField(
            hintText: AppStrings.sampleGuestEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.mobileNumber),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingSm,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
                child: const Row(
                  children: [
                    Text('+1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Expanded(
                child: AppTextField(
                  hintText: AppStrings.sampleGuestPhone,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.attendingEvent),
          const AppTextField(
            hintText: AppStrings.welcomeGala,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.comingFrom),
          const AppTextField(
            hintText: AppStrings.sampleGuestLocation,
            prefixIcon: Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.status),
          Obx(() => _buildStatusToggle(
                selectedStatus: controller.primaryGuestStatus.value,
                onChanged: controller.setPrimaryGuestStatus,
              )),
        ],
      ),
    );
  }

  Widget _buildAdditionalGuestsCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.group_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.additionalGuests,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  AppStrings.addedCountBadge,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingXs),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              AppStrings.additionalGuestsSubtitle,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingLg),

          // Guest Cards list
          Obx(() => Column(
                children: List.generate(controller.additionalGuests.length, (index) {
                  final guest = controller.additionalGuests[index];
                  return _buildGuestItemTile(guest, index);
                }),
              )),

          const SizedBox(height: AppDimens.paddingLg),

          // New Guest Form Section
          Obx(() {
            if (controller.isNewGuestFormVisible.value) {
              return _buildNewGuestForm();
            }
            return const SizedBox.shrink();
          }),

          const SizedBox(height: AppDimens.paddingMd),

          // Add Guest Dashed Button
          GestureDetector(
            onTap: controller.toggleNewGuestForm,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                border: Border.all(
                  color: AppColors.primary.withAlpha(120),
                  style: BorderStyle.solid,
                ),
              ),
              child: const Center(
                child: Text(
                  AppStrings.addGuestBtn,
                  style: TextStyle(
                    color: AppColors.primary,
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
  }

  Widget _buildGuestItemTile(RsvpGuest guest, int index) {
    final isConfirmed = guest.status == 'Confirmed';
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.paddingMd),
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE5E7EB),
            child: Text(
              guest.initial,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
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
                    Text(
                      guest.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isConfirmed
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isConfirmed
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFFD97706),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            guest.status,
                            style: TextStyle(
                              color: isConfirmed
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFFD97706),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  guest.email,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  guest.phone,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textSecondary),
            onSelected: (val) {
              if (val == 'delete') {
                controller.removeGuest(index);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 16, color: AppColors.textPrimary),
                    SizedBox(width: 8),
                    Text(AppStrings.edit),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 16, color: AppColors.error),
                    SizedBox(width: 8),
                    Text(AppStrings.delete, style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewGuestForm() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.newGuestDetails,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: controller.toggleNewGuestForm,
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.fullName),
          const AppTextField(hintText: AppStrings.enterFullName),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.mobileNumber),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingSm,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  color: AppColors.white,
                ),
                child: const Row(
                  children: [
                    Text('+1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Expanded(
                child: AppTextField(
                  hintText: '555-0000',
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.emailId),
          const AppTextField(
            hintText: 'email@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.status),
          Obx(() => _buildStatusToggle(
                selectedStatus: controller.newGuestStatus.value,
                onChanged: controller.setNewGuestStatus,
              )),
          const SizedBox(height: AppDimens.paddingLg),
          AppButton(
            text: AppStrings.saveGuest,
            onPressed: controller.saveGuest,
            borderRadius: AppDimens.radiusMd,
            height: 48,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusToggle({
    required String selectedStatus,
    required Function(String) onChanged,
  }) {
    final statuses = [
      AppStrings.confirmed,
      AppStrings.pending,
      AppStrings.declined,
    ];
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingXs),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Row(
        children: statuses.map((status) {
          final isSelected = selectedStatus == status;
          Color activeTextColor = AppColors.textPrimary;
          if (isSelected) {
            if (status == AppStrings.confirmed) activeTextColor = const Color(0xFF16A34A);
            if (status == AppStrings.declined) activeTextColor = AppColors.error;
          }
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(status),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isSelected ? activeTextColor : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
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
            text: AppStrings.saveDraft,
            isOutlined: true,
            onPressed: controller.saveDraft,
            borderRadius: AppDimens.radiusMd,
          ),
        ),
        const SizedBox(width: AppDimens.paddingMd),
        Expanded(
          flex: 1,
          child: AppButton(
            text: AppStrings.nextStepArrow,
            onPressed: controller.nextStep,
            borderRadius: AppDimens.radiusMd,
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
