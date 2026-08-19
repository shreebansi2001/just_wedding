import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/theme/app_text_styles.dart';
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
                      
                      _buildSectionTitle('Personal Information'),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: controller.firstNameController,
                              hintText: 'First Name',
                              prefixIcon: const Icon(Icons.person_outline, color: AppColors.hint),
                            ),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: AppTextField(
                              controller: controller.lastNameController,
                              hintText: 'Last Name',
                              prefixIcon: const Icon(Icons.person_outline, color: AppColors.hint),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail_outline, color: AppColors.hint),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.contactNoController,
                        hintText: 'Mobile Number',
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.hint),
                      ),
                      
                      const SizedBox(height: AppDimens.paddingXl),
                      _buildSectionTitle('Company Information'),
                      const SizedBox(height: AppDimens.paddingMd),
                      AppTextField(
                        controller: controller.companyNameController,
                        hintText: 'Company Name',
                        prefixIcon: const Icon(Icons.business_outlined, color: AppColors.hint),
                      ),
                      const SizedBox(height: AppDimens.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              if (controller.isLocationLoading.value && controller.states.isEmpty) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              return DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  hintText: 'State',
                                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.hint),
                                  prefixIcon: const Icon(Icons.map_outlined, color: AppColors.hint),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                                  ),
                                ),
                                value: controller.selectedStateId.value,
                                items: controller.states.map((state) {
                                  return DropdownMenuItem<int>(
                                    value: state.id,
                                    child: Text(state.name, style: AppTextStyles.body),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedStateId.value = value;
                                    controller.selectedCityId.value = null; // Reset city when state changes
                                    controller.fetchCities(value);
                                  }
                                },
                              );
                            }),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: Obx(() {
                              if (controller.isLocationLoading.value && controller.cities.isEmpty) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              return DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  hintText: 'City',
                                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.hint),
                                  prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.hint),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                                  ),
                                ),
                                value: controller.selectedCityId.value,
                                items: controller.cities.map((city) {
                                  return DropdownMenuItem<int>(
                                    value: city.id,
                                    child: Text(city.name, style: AppTextStyles.body),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedCityId.value = value;
                                  }
                                },
                              );
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimens.paddingXl),
                      _buildSectionTitle('Security'),
                      const SizedBox(height: AppDimens.paddingMd),
                      Obx(() => AppTextField(
                            controller: controller.passwordController,
                            hintText: 'Password',
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
                            hintText: 'Confirm Password',
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
                        text: 'Create Account',
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
          'Create Your Account',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: AppDimens.paddingSm),
        Text(
          'Set up your workspace and start managing your events with ease.',
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
          'Already have an account?',
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
            'Sign In',
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
