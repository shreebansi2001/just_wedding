import 'package:get/get.dart';
import '../controllers/event_execution_controller.dart';

class EventExecutionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventExecutionController>(() => EventExecutionController());
  }
}
