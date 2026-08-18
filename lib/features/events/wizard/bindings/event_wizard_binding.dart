import 'package:get/get.dart';
import '../controllers/event_wizard_controller.dart';

class EventWizardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventWizardController>(() => EventWizardController());
  }
}
