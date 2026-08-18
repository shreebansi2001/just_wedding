import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/models/auth_models.dart';
import 'package:dio/dio.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNoController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyEmailController = TextEditingController();
  final officeNoController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isMobileVisible = false.obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    contactNoController.dispose();
    companyNameController.dispose();
    companyEmailController.dispose();
    officeNoController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleMobileVisibility() {
    isMobileVisible.value = !isMobileVisible.value;
  }

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;
      final request = SignupRequest(
        address: addressController.text,
        cityId: 0,
        clientId: 0,
        companyEmail: companyEmailController.text,
        companyName: companyNameController.text,
        confirmPassword: confirmPasswordController.text,
        contactNo: contactNoController.text,
        countryCode: "+91",
        countryId: 0,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        officeNo: officeNoController.text,
        password: passwordController.text,
        roleId: 0,
        stateId: 0,
      );
      
      final response = await _authRepository.signup(request);
      _handleTokenResponse(response);
      
      Get.snackbar('Success', 'Account created successfully!');
      Get.offAllNamed(AppRoutes.layout);
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Failed to register');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleTokenResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      final token = response['token'] ?? response['accessToken'] ?? response['data']?['token'];
      if (token != null && token.toString().isNotEmpty) {
        _authService.setToken(token.toString());
      }
    }
  }

  void signIn() {
    Get.back(); // Go back to sign in
  }
}
