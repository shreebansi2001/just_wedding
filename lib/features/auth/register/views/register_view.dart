import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary, size: 22),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, r) {
            return Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.pick(mobile: 420, tablet: 480)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: AppDimens.paddingLg),
                      
                      _buildSectionTitle(AppStrings.personalInformation),
                      const SizedBox(height: AppDimens.paddingSm),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: controller.firstNameController,
                              hintText: AppStrings.firstName,
                              prefixIcon: const Icon(Icons.person_outline, color: AppColors.hint, size: 20),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: AppTextField(
                              controller: controller.lastNameController,
                              hintText: AppStrings.lastName,
                              prefixIcon: const Icon(Icons.person_outline, color: AppColors.hint, size: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.emailController,
                        hintText: AppStrings.emailAddress,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail_outline, color: AppColors.hint, size: 20),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Obx(() => AppTextField(
                            controller: controller.contactNoController,
                            hintText: AppStrings.mobileNumber,
                            keyboardType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.hint, size: 20),
                            obscureText: false,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isMobileVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.hint,
                                size: 20,
                              ),
                              onPressed: controller.toggleMobileVisibility,
                            ),
                          )),
                      
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildSectionTitle(AppStrings.companyInformation),
                      const SizedBox(height: AppDimens.paddingSm),
                      AppTextField(
                        controller: controller.companyNameController,
                        hintText: AppStrings.companyName,
                        prefixIcon: const Icon(Icons.apartment_outlined, color: AppColors.hint, size: 20),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              hintText: AppStrings.state,
                              prefixIcon: const Icon(Icons.map_outlined, color: AppColors.hint, size: 20),
                              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.hint, size: 20),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: AppTextField(
                              hintText: AppStrings.city,
                              prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.hint, size: 20),
                              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.hint, size: 20),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimens.paddingLg),
                      _buildSectionTitle(AppStrings.security),
                      const SizedBox(height: AppDimens.paddingSm),
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
                      const SizedBox(height: AppDimens.paddingMd),
                      Obx(() => AppTextField(
                            controller: controller.confirmPasswordController,
                            hintText: AppStrings.confirmPassword,
                            obscureText: !controller.isConfirmPasswordVisible.value,
                            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.hint, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmPasswordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.hint,
                                size: 20,
                              ),
                              onPressed: controller.toggleConfirmPasswordVisibility,
                            ),
                          )),

                      const SizedBox(height: AppDimens.paddingXl),
                      Obx(() => AppButton(
                        text: AppStrings.createAccount,
                        onPressed: controller.register,
                        isLoading: controller.isLoading.value,
                        borderRadius: AppDimens.radiusLg,
                        height: 56,
                        hasShadow: true,
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.createYourAccount,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.registerSubtitle,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.publicSans(
        color: AppColors.primary,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: controller.signIn,
          child: Text(
            AppStrings.signIn,
            style: GoogleFonts.publicSans(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

