import 'package:get/get.dart';
import '../controllers/layout_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../events/execution/controllers/event_execution_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutController>(() => LayoutController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<EventExecutionController>(() => EventExecutionController());
  }
}
