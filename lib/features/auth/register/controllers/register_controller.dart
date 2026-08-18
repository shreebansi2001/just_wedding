import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/models/auth_models.dart';
import 'package:dio/dio.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/location_repository.dart';
import '../../../../domain/models/location_models.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final LocationRepository _locationRepository = Get.find<LocationRepository>();
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
  final isLoading = false.obs;
  
  final states = <LocationModel>[].obs;
  final cities = <LocationModel>[].obs;
  final selectedStateId = Rxn<int>();
  final selectedCityId = Rxn<int>();
  final isLocationLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchStates();
  }

  Future<void> _fetchStates() async {
    try {
      isLocationLoading.value = true;
      final result = await _locationRepository.getStates();
      states.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load states');
    } finally {
      isLocationLoading.value = false;
    }
  }

  Future<void> fetchCities(int stateId) async {
    try {
      isLocationLoading.value = true;
      selectedStateId.value = stateId;
      selectedCityId.value = null; // reset city when state changes
      final result = await _locationRepository.getCities(stateId);
      cities.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cities');
    } finally {
      isLocationLoading.value = false;
    }
  }

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

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }
    
    if (selectedStateId.value == null || selectedCityId.value == null) {
      Get.snackbar('Error', 'Please select a state and city');
      return;
    }

    try {
      isLoading.value = true;
      final request = SignupRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        contactNo: contactNoController.text,
        companyName: companyNameController.text,
        companyEmail: companyEmailController.text,
        officeNo: officeNoController.text,
        address: addressController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        cityId: selectedCityId.value!,
        stateId: selectedStateId.value!,
        countryId: 1,
        clientId: 0,
        roleId: 2,
        countryCode: '+91',
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
