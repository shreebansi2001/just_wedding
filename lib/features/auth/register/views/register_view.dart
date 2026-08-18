import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, r) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.pick(mobile: 600, tablet: 500)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: AppDimens.paddingXxl),
                      
                      _buildSectionTitle(AppStrings.personalInformation),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: controller.firstNameController,
                              hintText: AppStrings.firstName,
                              prefixIcon: const Icon(Icons.person_outline, color: AppColors.hint),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: AppTextField(
                              controller: controller.lastNameController,
                              hintText: AppStrings.lastName,
                              prefixIcon: const Icon(Icons.person_outline, color: AppColors.hint),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.emailController,
                        hintText: AppStrings.emailAddress,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail_outline, color: AppColors.hint),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Obx(() => AppTextField(
                            controller: controller.contactNoController,
                            hintText: AppStrings.mobileNumber,
                            keyboardType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.hint),
                            obscureText: false,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isMobileVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.hint,
                              ),
                              onPressed: controller.toggleMobileVisibility,
                            ),
                          )),
                      
                      const SizedBox(height: AppDimens.paddingXl),
                      _buildSectionTitle(AppStrings.companyInformation),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.companyNameController,
                        hintText: AppStrings.companyName,
                        prefixIcon: const Icon(Icons.business_outlined, color: AppColors.hint),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: controller.companyEmailController,
                              hintText: 'Company Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.mail_outline, color: AppColors.hint),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: AppTextField(
                              controller: controller.officeNoController,
                              hintText: 'Office Number',
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.hint),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.addressController,
                        hintText: 'Company Address',
                        prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.hint),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              hintText: AppStrings.state,
                              prefixIcon: const Icon(Icons.map_outlined, color: AppColors.hint),
                              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.hint),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: AppTextField(
                              hintText: AppStrings.city,
                              prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.hint),
                              suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.hint),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimens.paddingXl),
                      _buildSectionTitle(AppStrings.security),
                      const SizedBox(height: AppDimens.paddingMd),
                      Obx(() => AppTextField(
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
                          )),
                      const SizedBox(height: AppDimens.paddingMd),
                      Obx(() => AppTextField(
                            controller: controller.confirmPasswordController,
                            hintText: AppStrings.confirmPassword,
                            obscureText: !controller.isConfirmPasswordVisible.value,
                            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.hint),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmPasswordVisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.hint,
                              ),
                              onPressed: controller.toggleConfirmPasswordVisibility,
                            ),
                          )),

                      const SizedBox(height: AppDimens.paddingXxl),
                      Obx(() => AppButton(
                        text: AppStrings.createAccount,
                        onPressed: controller.register,
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

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.createYourAccount,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: AppDimens.paddingSm),
        Text(
          AppStrings.registerSubtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: controller.signIn,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            AppStrings.signIn,
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
