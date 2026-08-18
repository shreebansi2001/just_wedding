import 'package:get/get.dart';
import '../controllers/create_rsvp_controller.dart';

class CreateRsvpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRsvpController>(() => CreateRsvpController());
  }
}
