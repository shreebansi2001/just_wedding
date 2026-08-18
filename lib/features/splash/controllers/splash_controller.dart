import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation finished perfectly at 1.0
        // Temporarily commented out navigation so you can see it hold!
        // Get.offAllNamed(AppRoutes.onboarding);
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
