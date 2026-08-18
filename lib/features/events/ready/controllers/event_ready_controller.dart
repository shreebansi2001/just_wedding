import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class EventReadyController extends GetxController {
  void goToDashboard() {
    Get.offAllNamed(AppRoutes.layout);
  }

  void goToEvents() {
    Get.offAllNamed(AppRoutes.layout);
  }
}
