import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                _buildTopBar(r),
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

  /// Top bar with back arrow (page 2+) and Skip (pages 0-1)
  Widget _buildTopBar(ResponsiveInfo r) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSm),
        child: Obx(() {
          final page = controller.currentPage.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back arrow on page > 0
              if (page > 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  onPressed: controller.back,
                )
              else
                const SizedBox(width: 48),

              // Skip on pages 0 and 1
              if (page < 2)
                TextButton(
                  onPressed: controller.skip,
                  child: const Text(
                    AppStrings.skip,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
                const SizedBox(width: 48),
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
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      child: Column(
        children: [
          SizedBox(height: r.pick(mobile: AppDimens.paddingMd, tablet: AppDimens.paddingXl)),
          // Illustration area
          illustration,
          SizedBox(height: r.pick(mobile: AppDimens.paddingXl, tablet: AppDimens.paddingXxl)),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: r.pick(mobile: 28, tablet: 36),
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: r.pick(mobile: 15, tablet: 17),
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppDimens.paddingXl),
        ],
      ),
    );
  }

  /// Bottom section: dot indicators + button
  Widget _buildBottomSection(ResponsiveInfo r) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimens.paddingLg,
        AppDimens.paddingSm,
        AppDimens.paddingLg,
        r.pick(mobile: AppDimens.paddingXl, tablet: AppDimens.paddingXxl),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDotIndicator(),
          const SizedBox(height: AppDimens.paddingLg),
          Obx(() {
            final page = controller.currentPage.value;
            return AppButton(
              text: page == 2
                  ? AppStrings.getStartedArrow
                  : page == 1
                      ? AppStrings.next
                      : AppStrings.getStarted,
              onPressed: controller.next,
              borderRadius: AppDimens.radiusFull,
              height: AppDimens.buttonHeightLg,
              width: r.pick(mobile: double.infinity, tablet: 400),
              icon: page == 2
                  ? const Icon(Icons.arrow_forward, color: AppColors.white, size: 20)
                  : null,
            );
          }),
        ],
      ),
    );
  }

  /// Three dot indicators: active = elongated pill, inactive = small circle
  Widget _buildDotIndicator() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = controller.currentPage.value == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: isActive ? 24 : 8,
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
