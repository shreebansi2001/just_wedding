import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header: "1. Clients Name" + add button
          Row(
            children: [
              Expanded(
                child: Text(
                  '${index + 1}. ${AppStrings.clientsName}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Add button (green circle with +)
              GestureDetector(
                onTap: controller.addClient,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: AppColors.white, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Name row: prefix dropdown + name field
          Row(
            children: [
              // Prefix dropdown
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingSm,
                  vertical: AppDimens.paddingXs,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: client.prefix,
                    isDense: true,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
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
              const SizedBox(width: AppDimens.paddingSm),
              // Name field
              Expanded(
                child: AppTextField(
                  hintText: AppStrings.fullLegalName,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Mobile Number
          _buildLabel(AppStrings.mobileNumber),
          const SizedBox(height: AppDimens.paddingXs),
          AppTextField(
            hintText: client.mobile.isNotEmpty ? client.mobile : '+91 XXXXX XXXXX',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Address
          _buildLabel(AppStrings.address),
          const SizedBox(height: AppDimens.paddingXs),
          const AppTextField(
            hintText: AppStrings.addressHint,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
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
            onPressed: controller.cancel,
            borderRadius: AppDimens.radiusMd,
          ),
        ),
        const SizedBox(width: AppDimens.paddingMd),
        Expanded(
          flex: 2,
          child: AppButton(
            text: AppStrings.continueToFunction,
            onPressed: controller.nextStep,
            borderRadius: AppDimens.radiusMd,
          ),
        ),
      ],
    );
  }
}
