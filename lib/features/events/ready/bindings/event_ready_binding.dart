import 'package:get/get.dart';
import '../controllers/event_ready_controller.dart';

class EventReadyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventReadyController>(() => EventReadyController());
  }
}
