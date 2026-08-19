import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../onboarding/views/widgets/onboarding_illustrations.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, r) {
            return Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.pick(mobile: 400, tablet: 450)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppDimens.paddingMd),
                      _buildLogo(),
                      const SizedBox(height: AppDimens.paddingLg),
                      const Center(child: SignInIllustration()),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildHeader(),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildForm(),
                      const SizedBox(height: AppDimens.paddingMd),
                      _buildActions(),
                      const SizedBox(height: AppDimens.paddingXl),
                      Obx(() => AppButton(
                        text: AppStrings.signIn,
                        onPressed: controller.submit,
                        isLoading: controller.isLoading.value,
                        borderRadius: AppDimens.radiusLg,
                        height: 56,
                        hasShadow: true,
                      )),
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

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryTint,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          child: Text(
            'JE',
            style: GoogleFonts.publicSans(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: AppDimens.paddingMd),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.justEvent,
              style: GoogleFonts.publicSans(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              AppStrings.enterpriseEdition,
              style: GoogleFonts.publicSans(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.welcomeBack,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.signInSubtitle,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        AppTextField(
          controller: controller.emailController,
          hintText: AppStrings.emailAddress,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.mail_outline, color: AppColors.hint, size: 20),
        ),
        const SizedBox(height: AppDimens.paddingMd),
        Obx(() => AppTextField(
          controller: controller.passwordController,
          hintText: AppStrings.password,
          obscureText: !controller.isPasswordVisible.value,
          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.hint, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: AppColors.hint,
              size: 20,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
        )),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () => controller.toggleRememberMe(!controller.rememberMe.value),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: controller.toggleRememberMe,
                    activeColor: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(color: AppColors.border, width: 1.5),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppStrings.rememberMe,
                  style: GoogleFonts.publicSans(
                    color: const Color(0xFF475569),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }),
        GestureDetector(
          onTap: controller.forgotPassword,
          child: Text(
            AppStrings.forgotPassword,
            style: GoogleFonts.publicSans(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

