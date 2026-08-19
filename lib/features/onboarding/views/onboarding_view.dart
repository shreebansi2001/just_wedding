import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_button.dart';
import '../controllers/onboarding_controller.dart';
import 'widgets/onboarding_illustrations.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, r) {
            return Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: [
                      _buildPage(
                        illustration: const OnboardingIllustration1(),
                        title: AppStrings.onboardingTitle1,
                        subtitle: AppStrings.onboardingSubtitle1,
                        r: r,
                      ),
                      _buildPage(
                        illustration: const OnboardingIllustration2(),
                        title: AppStrings.onboardingTitle2,
                        subtitle: AppStrings.onboardingSubtitle2,
                        r: r,
                      ),
                      _buildPage(
                        illustration: const OnboardingIllustration3(),
                        title: AppStrings.onboardingTitle3,
                        subtitle: AppStrings.onboardingSubtitle3,
                        r: r,
                      ),
                    ],
                  ),
                ),
                _buildBottomSection(r),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Top bar with back arrow (page 2) and Skip (pages 0-1)
  Widget _buildTopBar() {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMd),
        child: Obx(() {
          final page = controller.currentPage.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back arrow on page == 2 (Screen 3 in Figma)
              if (page == 2)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.textSecondary, size: 22),
                  onPressed: controller.back,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              else
                const SizedBox(width: 32),

              // Skip on pages 0 and 1
              if (page < 2)
                GestureDetector(
                  onTap: controller.skip,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      AppStrings.skip,
                      style: GoogleFonts.publicSans(
                        color: AppColors.hint,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(width: 32),
            ],
          );
        }),
      ),
    );
  }

  /// Single page content: illustration + title + subtitle
  Widget _buildPage({
    required Widget illustration,
    required String title,
    required String subtitle,
    required ResponsiveInfo r,
  }) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Column(
        children: [
          illustration,
          const SizedBox(height: AppDimens.paddingXl),
          // Title with exact Figma specs: Public Sans Bold 30px, line-height 37.5px (-0.75 letter spacing)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.publicSans(
                color: AppColors.textPrimary,
                fontSize: r.pick(mobile: 28, tablet: 32),
                fontWeight: FontWeight.w700,
                height: 1.25,
                letterSpacing: -0.75,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          // Subtitle with exact Figma specs: Public Sans Regular 14px, #64748B
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.publicSans(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingLg),
        ],
      ),
    );
  }

  /// Bottom section: dot indicators + button
  Widget _buildBottomSection(ResponsiveInfo r) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimens.paddingLg,
        0,
        AppDimens.paddingLg,
        r.pick(mobile: AppDimens.paddingLg, tablet: AppDimens.paddingXl),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDotIndicator(),
          const SizedBox(height: AppDimens.paddingXl),
          Obx(() {
            final page = controller.currentPage.value;
            return SizedBox(
              width: r.pick(mobile: double.infinity, tablet: 340),
              child: AppButton(
                text: page == 2
                    ? 'GET STARTED'
                    : page == 1
                        ? 'NEXT'
                        : 'GET STARTED',
                onPressed: controller.next,
                borderRadius: AppDimens.radiusFull,
                height: 56,
                hasShadow: true,
                icon: page == 2
                    ? const Icon(Icons.arrow_forward, color: AppColors.white, size: 18)
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Three dot indicators: active = elongated pill, inactive = circle
  Widget _buildDotIndicator() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = controller.currentPage.value == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 6,
            width: isActive ? 24 : 6,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.dotInactive,
              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
            ),
          );
        }),
      );
    });
  }
}

