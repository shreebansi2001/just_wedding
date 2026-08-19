import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../domain/models/auth_models.dart';
import 'package:dio/dio.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/services/auth_service.dart';

enum LoginMethod { email, otp }

class SignInController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final loginMethod = LoginMethod.email.obs;
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contactNoController = TextEditingController();
  final otpController = TextEditingController();

  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;
  final isLoading = false.obs;
  final isOtpSent = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    contactNoController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  void setLoginMethod(LoginMethod method) {
    loginMethod.value = method;
    isOtpSent.value = false;
  }

  Future<void> signInWithEmail() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    try {
      isLoading.value = true;
      final request = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );
      final response = await _authRepository.login(request);
      _handleTokenResponse(response);
      Get.offAllNamed(AppRoutes.layout);
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Login failed');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestOtp() async {
    if (contactNoController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter contact number');
      return;
    }

    try {
      isLoading.value = true;
      final request = OtpRequest(contactNo: contactNoController.text);
      await _authRepository.requestOtp(request);
      isOtpSent.value = true;
      Get.snackbar('Success', 'OTP sent to your contact number');
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Failed to request OTP');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter OTP');
      return;
    }

    try {
      isLoading.value = true;
      final request = OtpVerifyRequest(
        contactNo: contactNoController.text,
        otp: otpController.text,
      );
      final response = await _authRepository.verifyOtp(request);
      _handleTokenResponse(response);
      Get.offAllNamed(AppRoutes.layout);
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Invalid OTP');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleTokenResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      // Look for the token in typical places
      final token = response['token'] ?? response['accessToken'] ?? response['data']?['token'];
      if (token != null && token.toString().isNotEmpty) {
        _authService.setToken(token.toString());
      }
      
      // Look for the user ID based on the provided JSON structure
      final userId = response['data']?['id'] ?? response['userId'] ?? response['user']?['id'];
      if (userId != null) {
        _authService.setUserId(int.tryParse(userId.toString()) ?? 0);
      }
    }
  }

  void submit() {
    if (loginMethod.value == LoginMethod.email) {
      signInWithEmail();
    } else {
      if (isOtpSent.value) {
        verifyOtp();
      } else {
        requestOtp();
      }
    }
  }

  void forgotPassword() {
    // Navigate to forgot password flow
  }

  void navigateToRegister() {
    Get.toNamed(AppRoutes.register);
  }
}
