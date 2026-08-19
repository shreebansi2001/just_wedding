import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, r) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.pick(mobile: 600, tablet: 450)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingXl),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      _buildIllustration(),
                      const SizedBox(height: AppDimens.paddingXl),
                      Text(
                        AppStrings.yourEventIsReady,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.publicSans(
                          color: AppColors.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimens.paddingSm),
                      Text(
                        AppStrings.sampleEventName,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.publicSans(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimens.paddingSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: AppColors.hint,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.sampleEventDate,
                            style: GoogleFonts.publicSans(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.hint,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.sampleEventLocation,
                            style: GoogleFonts.publicSans(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingLg),
                      Text(
                        AppStrings.eventReadySubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.publicSans(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(flex: 3),
                      AppButton(
                        text: AppStrings.dashboard,
                        onPressed: controller.goToDashboard,
                        borderRadius: AppDimens.radiusMd,
                        height: 50,
                        hasShadow: true,
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppButton(
                        text: AppStrings.goToEvents,
                        isOutlined: true,
                        hasShadow: false,
                        textColor: AppColors.primary,
                        backgroundColor: AppColors.border,
                        onPressed: controller.goToEvents,
                        borderRadius: AppDimens.radiusMd,
                        height: 50,
                      ),
                      const SizedBox(height: AppDimens.paddingXl),
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
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryTint,
            ),
          ),

          // Confetti pieces
          ..._buildConfetti(),

          // Clipboard
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primary, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Clipboard clip top
                Container(
                  width: 38,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _buildCheckLine(),
                const SizedBox(height: 8),
                _buildCheckLine(),
                const SizedBox(height: 8),
                _buildCheckLine(),
              ],
            ),
          ),

          // Checkmark floating circle on bottom right of clipboard
          Positioned(
            right: 48,
            bottom: 36,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            size: 12,
            color: AppColors.primaryTint,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 5,
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
        top: 30,
        left: 35,
        child: Transform.rotate(
          angle: 0.3,
          child: Container(
            width: 7,
            height: 7,
            color: AppColors.primary,
          ),
        ),
      ),
      Positioned(
        top: 50,
        left: 20,
        child: Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFFFBBF24),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        bottom: 55,
        left: 25,
        child: Transform.rotate(
          angle: 0.5,
          child: Container(
            width: 6,
            height: 6,
            color: AppColors.primary.withValues(alpha: 0.8),
          ),
        ),
      ),
      Positioned(
        top: 40,
        right: 35,
        child: Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: AppColors.primaryTint,
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        bottom: 65,
        right: 25,
        child: Transform.rotate(
          angle: 0.2,
          child: Container(
            width: 6,
            height: 6,
            color: const Color(0xFF34D399),
          ),
        ),
      ),
    ];
  }
}

