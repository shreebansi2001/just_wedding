import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../controllers/create_rsvp_controller.dart';
import 'rsvp_stepper.dart';

class Step4TransportationView extends GetView<CreateRsvpController> {
  const Step4TransportationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          AppStrings.transportationDetails,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppDimens.paddingXs),
        const Text(
          AppStrings.transportationSubtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppDimens.paddingLg),
        const RsvpStepper(currentStep: 4),
        const SizedBox(height: AppDimens.paddingLg),
        _buildTransportationFormCard(),
        const SizedBox(height: AppDimens.paddingXxl),
        _buildBottomButtons(),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildTransportationFormCard() {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.pickupDate),
                    const AppTextField(
                      hintText: '10/15/2026',
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
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
                    _buildFieldLabel(AppStrings.dropOffDate),
                    const AppTextField(
                      hintText: '10/18/2026',
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.modeOfTransport),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMd,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              color: AppColors.white,
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.directions_bus_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: AppDimens.paddingMd),
                Expanded(
                  child: Text(
                    AppStrings.premiumBus,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.unfold_more,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.pickupLocation),
          const AppTextField(
            hintText: AppStrings.samplePickupLocation,
            prefixIcon: Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.dropOffLocation),
          const AppTextField(
            hintText: AppStrings.sampleDropOffLocation,
            prefixIcon: Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel(AppStrings.vehicles),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: controller.decrementVehicles,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: const Text(
                              '−',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Obx(() => Text(
                                '${controller.vehiclesCount.value}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: controller.incrementVehicles,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.serviceProvider),
                    const AppTextField(
                      hintText: AppStrings.sampleServiceProvider,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildFieldLabel(AppStrings.paymentStatus),
          const AppTextField(
            hintText: AppStrings.pending,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              _buildFieldLabel(AppStrings.specialRequests),
              const SizedBox(width: 4),
              const Text(
                AppStrings.optional,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  maxLines: 3,
                  style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: AppStrings.specialRequestsTransportHint,
                    hintStyle: TextStyle(fontSize: 13, color: AppColors.hint),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.mic_none_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
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
            text: AppStrings.finishRsvp,
            onPressed: controller.finishRsvp,
            borderRadius: AppDimens.radiusMd,
            icon: const Icon(
              Icons.check_circle_outline,
              color: AppColors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
