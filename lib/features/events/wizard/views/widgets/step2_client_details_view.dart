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

class Step2ClientDetailsView extends GetView<EventWizardController> {
  const Step2ClientDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WizardProgressBar(
          currentStep: 2,
          totalSteps: 4,
          title: AppStrings.clientDetails,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        Obx(() => Column(
              children: List.generate(controller.clients.length, (index) {
                return _buildClientCard(index);
              }),
            )),
        const SizedBox(height: AppDimens.paddingXxl),
        _buildBottomButtons(),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildClientCard(int index) {
    final client = controller.clients[index];
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.paddingLg),
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
          // Section header: "Clients Name"
          Text(
            AppStrings.clientsName,
            style: GoogleFonts.publicSans(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Name row: prefix dropdown + name field + square plus button
          Row(
            children: [
              // Prefix dropdown
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, width: 1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  color: AppColors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: client.prefix,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint, size: 18),
                    style: GoogleFonts.publicSans(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    items: ['Mr.', 'Mrs.', 'Ms.', 'Dr.']
                        .map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        client.prefix = val;
                        controller.clients.refresh();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Name field
              Expanded(
                child: AppTextField(
                  hintText: AppStrings.fullLegalName,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.hint,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Square plus button
              GestureDetector(
                onTap: controller.addClient,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: AppColors.white, size: 22),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Mobile Number
          _buildLabel(AppStrings.mobileNumber),
          const SizedBox(height: AppDimens.paddingXs),
          AppTextField(
            hintText: client.mobile.isNotEmpty ? client.mobile : '+91 89624 39648',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Address
          _buildLabel(AppStrings.address),
          const SizedBox(height: AppDimens.paddingXs),
          const AppTextField(
            hintText: AppStrings.addressHint,
            maxLines: 3,
          ),
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

  Widget _buildBottomButtons() {
    return Row(
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
            text: AppStrings.continueToFunction,
            onPressed: controller.nextStep,
            borderRadius: AppDimens.radiusMd,
            height: 48,
            hasShadow: true,
          ),
        ),
      ],
    );
  }
}

