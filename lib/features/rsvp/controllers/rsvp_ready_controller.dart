import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class RsvpReadyController extends GetxController {
  void viewRsvp() {
    Get.offAllNamed(AppRoutes.layout);
  }

  void addAnotherGuest() {
    Get.offNamed(AppRoutes.createRsvp);
  }

  void backToEvents() {
    Get.offAllNamed(AppRoutes.layout);
  }
}
