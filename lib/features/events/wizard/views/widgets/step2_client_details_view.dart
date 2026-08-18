import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../domain/models/event_dtos.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Labels Row
        Row(
          children: [
            Text(
              '${index + 1}. ${AppStrings.clientsName} *',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: controller.addClient,
              child: const Text(
                '+ Add New',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            const Expanded(
              child: Text(
                AppStrings.mobileNumber,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingSm),

        // Inputs Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prefix
            Container(
              height: 48, // matching typical text field height
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSm),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppDimens.radiusSm),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: client.prefix,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                  items: ['Mr.', 'Mrs.', 'Ms.', 'Dr.']
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
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
            const SizedBox(width: AppDimens.paddingMd),
            // Party Search / Autocomplete
            Expanded(
              flex: 2,
              child: Autocomplete<PartyResponseDto>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  return await controller.searchParties(textEditingValue.text);
                },
                displayStringForOption: (PartyResponseDto option) => option.nameEnglish ?? '',
                onSelected: (PartyResponseDto selection) {
                  client.partyId = selection.id;
                  controller.clients.refresh();
                },
                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                  return AppTextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    hintText: 'Search full legal name...',
                    suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        width: MediaQuery.of(context).size.width * 0.4, // Match width approximately
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final PartyResponseDto option = options.elementAt(index);
                            return InkWell(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Text(
                                  option.nameEnglish ?? '',
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            // Mobile Number
            Expanded(
              flex: 1,
              child: AppTextField(
                hintText: '',
                keyboardType: TextInputType.phone,
                onChanged: (val) {
                  client.mobile = val;
                  controller.clients.refresh();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingLg),

        // Address
        _buildLabel(AppStrings.address),
        const SizedBox(height: AppDimens.paddingXs),
        AppTextField(
          hintText: '',
          maxLines: 4,
          onChanged: (val) {
            client.address = val;
            controller.clients.refresh();
          },
        ),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
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
