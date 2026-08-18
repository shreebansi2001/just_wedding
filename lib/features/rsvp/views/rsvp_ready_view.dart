import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/rsvp_ready_controller.dart';

class RsvpReadyView extends GetView<RsvpReadyController> {
  const RsvpReadyView({super.key});

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
                      const Spacer(flex: 3),
                      _buildSuccessBadge(),
                      const SizedBox(height: AppDimens.paddingXxl),
                      const Text(
                        AppStrings.rsvpCreatedSuccessfully,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      const Text(
                        AppStrings.rsvpSuccessSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(flex: 4),
                      AppButton(
                        text: AppStrings.viewRsvp,
                        onPressed: controller.viewRsvp,
                        borderRadius: AppDimens.radiusMd,
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppButton(
                        text: AppStrings.addAnotherGuest,
                        isOutlined: true,
                        backgroundColor: AppColors.primaryLight,
                        textColor: AppColors.primary,
                        onPressed: controller.addAnotherGuest,
                        borderRadius: AppDimens.radiusMd,
                      ),
                      const SizedBox(height: AppDimens.paddingLg),
                      TextButton(
                        onPressed: controller.backToEvents,
                        child: const Text(
                          AppStrings.backToEvents,
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

  Widget _buildSuccessBadge() {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft radial glow background
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withAlpha(50),
                  AppColors.primary.withAlpha(20),
                  Colors.transparent,
                ],
                stops: const [0.2, 0.6, 1.0],
              ),
            ),
          ),

          // Sparkle stars
          ..._buildSparkles(),

          // White circle with badge inside
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(30),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSparkles() {
    return [
      const Positioned(
        top: 35,
        right: 45,
        child: Icon(
          Icons.auto_awesome,
          size: 16,
          color: Color(0xFFF472B6),
        ),
      ),
      const Positioned(
        bottom: 50,
        left: 45,
        child: Icon(
          Icons.star_outline,
          size: 14,
          color: Color(0xFFF472B6),
        ),
      ),
      const Positioned(
        top: 60,
        left: 35,
        child: Icon(
          Icons.star_outline,
          size: 12,
          color: Color(0xFFF472B6),
        ),
      ),
    ];
  }
}
