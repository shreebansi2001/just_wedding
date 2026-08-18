import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.pick(mobile: 600, tablet: 450)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: r.pick(mobile: AppDimens.paddingMd, tablet: AppDimens.paddingXl)),
                      _buildLogo(),
                      const SizedBox(height: AppDimens.paddingLg),
                      const SignInIllustration(),
                      SizedBox(height: r.pick(mobile: AppDimens.paddingXl, tablet: AppDimens.paddingXxl)),
                      _buildHeader(),
                      const SizedBox(height: AppDimens.paddingXl),
                      _buildForm(),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildActions(),
                      const SizedBox(height: AppDimens.paddingXl),
                      Obx(() => AppButton(
                        text: controller.loginMethod.value == LoginMethod.otp && controller.isOtpSent.value
                            ? 'Verify OTP'
                            : (controller.loginMethod.value == LoginMethod.otp ? 'Request OTP' : AppStrings.signIn),
                        onPressed: controller.submit,
                        isLoading: controller.isLoading.value,
                        borderRadius: AppDimens.radiusFull,
                        height: AppDimens.buttonHeightLg,
                      )),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildFooter(),
                      const SizedBox(height: AppDimens.paddingXxl),
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
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          child: const Text(
            'JE',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: AppDimens.paddingMd),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.justEvent,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              AppStrings.enterpriseEdition,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.welcomeBack,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: AppDimens.paddingSm),
        Text(
          AppStrings.signInSubtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildLoginToggle(),
        const SizedBox(height: AppDimens.paddingXl),
        Obx(() {
          if (controller.loginMethod.value == LoginMethod.email) {
            return Column(
              children: [
                AppTextField(
                  controller: controller.emailController,
                  hintText: AppStrings.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline, color: AppColors.hint),
                ),
                const SizedBox(height: AppDimens.paddingMd),
                AppTextField(
                  controller: controller.passwordController,
                  hintText: AppStrings.password,
                  obscureText: !controller.isPasswordVisible.value,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.hint),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.hint,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                AppTextField(
                  controller: controller.contactNoController,
                  hintText: 'Mobile Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.hint),
                  readOnly: controller.isOtpSent.value,
                ),
                if (controller.isOtpSent.value) ...[
                  const SizedBox(height: AppDimens.paddingMd),
                  AppTextField(
                    controller: controller.otpController,
                    hintText: 'Enter OTP',
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.pin_outlined, color: AppColors.hint),
                  ),
                ],
              ],
            );
          }
        }),
      ],
    );
  }

  Widget _buildLoginToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Obx(() => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setLoginMethod(LoginMethod.email),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.loginMethod.value == LoginMethod.email 
                      ? AppColors.white 
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  boxShadow: controller.loginMethod.value == LoginMethod.email 
                      ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: controller.loginMethod.value == LoginMethod.email ? FontWeight.bold : FontWeight.w500,
                    color: controller.loginMethod.value == LoginMethod.email ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setLoginMethod(LoginMethod.otp),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.loginMethod.value == LoginMethod.otp 
                      ? AppColors.white 
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  boxShadow: controller.loginMethod.value == LoginMethod.otp 
                      ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Mobile OTP',
                  style: TextStyle(
                    fontWeight: controller.loginMethod.value == LoginMethod.otp ? FontWeight.bold : FontWeight.w500,
                    color: controller.loginMethod.value == LoginMethod.otp ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: controller.rememberMe.value,
                  onChanged: controller.toggleRememberMe,
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.rememberMe,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }),
        TextButton(
          onPressed: controller.forgotPassword,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            AppStrings.forgotPassword,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () => Get.toNamed('/register'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Create Account',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
