import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class LayoutController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    if (index == 1) {
      Get.toNamed(AppRoutes.createEvent);
    } else {
      selectedIndex.value = index;
    }
  }
}
