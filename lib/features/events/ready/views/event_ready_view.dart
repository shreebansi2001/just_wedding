import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/event_ready_controller.dart';

class EventReadyView extends GetView<EventReadyController> {
  const EventReadyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, r) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.pick(mobile: 600, tablet: 450)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      _buildIllustration(),
                      const SizedBox(height: AppDimens.paddingXxl),
                      const Text(
                        AppStrings.yourEventIsReady,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppDimens.paddingLg),
                      const Text(
                        AppStrings.sampleEventName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            AppStrings.sampleEventDate,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            AppStrings.sampleEventLocation,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingXl),
                      const Text(
                        AppStrings.eventReadySubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(flex: 3),
                      AppButton(
                        text: AppStrings.dashboard,
                        onPressed: controller.goToDashboard,
                        borderRadius: AppDimens.radiusMd,
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppButton(
                        text: AppStrings.goToEvents,
                        isOutlined: true,
                        backgroundColor: AppColors.primaryLight,
                        textColor: AppColors.primary,
                        onPressed: controller.goToEvents,
                        borderRadius: AppDimens.radiusMd,
                      ),
                      const SizedBox(height: AppDimens.paddingLg),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circular soft pink glow
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryLight.withAlpha(120),
            ),
          ),

          // Confetti pieces
          ..._buildConfetti(),

          // Clipboard
          Container(
            width: 110,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(20),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Clipboard clip top
                Container(
                  width: 44,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCheckLine(),
                const SizedBox(height: 10),
                _buildCheckLine(),
                const SizedBox(height: 10),
                _buildCheckLine(),
              ],
            ),
          ),

          // Checkmark floating circle on bottom right of clipboard
          Positioned(
            right: 38,
            bottom: 30,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(50),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildConfetti() {
    return [
      Positioned(
        top: 25,
        left: 30,
        child: Transform.rotate(
          angle: 0.3,
          child: Container(
            width: 8,
            height: 8,
            color: AppColors.primary,
          ),
        ),
      ),
      Positioned(
        top: 45,
        left: 15,
        child: Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFFFBBF24),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        left: 20,
        child: Transform.rotate(
          angle: 0.5,
          child: Container(
            width: 7,
            height: 7,
            color: AppColors.primary.withAlpha(180),
          ),
        ),
      ),
      Positioned(
        top: 35,
        right: 30,
        child: Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        bottom: 60,
        right: 20,
        child: Transform.rotate(
          angle: 0.2,
          child: Container(
            width: 7,
            height: 7,
            color: const Color(0xFF34D399),
          ),
        ),
      ),
    ];
  }
}
