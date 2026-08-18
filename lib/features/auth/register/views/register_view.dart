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
                              final selectedState = controller.states.firstWhereOrNull((s) => s.id == controller.selectedStateId.value);
                              return AppTextField(
                                hintText: selectedState?.name ?? 'State',
                                readOnly: true,
                                prefixIcon: const Icon(Icons.map_outlined, color: AppColors.hint),
                                suffixIcon: controller.isLocationLoading.value 
                                  ? const Padding(padding: EdgeInsets.all(12), child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)))
                                  : const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.hint),
                                onTap: () {
                                  if (controller.states.isEmpty) return;
                                  Get.bottomSheet(
                                    Container(
                                      color: AppColors.white,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.states.length,
                                        itemBuilder: (context, index) {
                                          final state = controller.states[index];
                                          return ListTile(
                                            title: Text(state.name),
                                            onTap: () {
                                              controller.fetchCities(state.id);
                                              Get.back();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                          const SizedBox(width: AppDimens.paddingMd),
                          Expanded(
                            child: Obx(() {
                              final selectedCity = controller.cities.firstWhereOrNull((c) => c.id == controller.selectedCityId.value);
                              return AppTextField(
                                hintText: selectedCity?.name ?? 'City',
                                readOnly: true,
                                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.hint),
                                suffixIcon: controller.isLocationLoading.value 
                                  ? const Padding(padding: EdgeInsets.all(12), child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)))
                                  : const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.hint),
                                onTap: () {
                                  if (controller.cities.isEmpty) return;
                                  Get.bottomSheet(
                                    Container(
                                      color: AppColors.white,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.cities.length,
                                        itemBuilder: (context, index) {
                                          final city = controller.cities[index];
                                          return ListTile(
                                            title: Text(city.name),
                                            onTap: () {
                                              controller.selectedCityId.value = city.id;
                                              Get.back();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
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
