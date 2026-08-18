import 'package:get/get.dart';
import '../controllers/rsvp_ready_controller.dart';

class RsvpReadyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsvpReadyController>(() => RsvpReadyController());
  }
}
