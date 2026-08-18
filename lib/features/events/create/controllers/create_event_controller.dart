import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class CreateEventController extends GetxController {
  final eventName = ''.obs;
  final eventType = 'Wedding'.obs; // Default
  final eventDate = ''.obs;
  final priority = 'High'.obs; // Default

  final eventTypes = [
    {'name': 'Wedding', 'icon': '💍'},
    {'name': 'Corporate', 'icon': '🏢'},
    {'name': 'Birthday', 'icon': '🎂'},
    {'name': 'Anniversary', 'icon': '🎉'},
    {'name': 'Baby Shower', 'icon': '👶'},
    {'name': 'Concert', 'icon': '🎵'},
    {'name': 'Graduation', 'icon': '🎓'},
    {'name': 'Awards', 'icon': '🏆'},
    {'name': 'Other', 'icon': '✨'},
  ];

  final priorities = ['High', 'Medium', 'Low'];

  void selectType(String type) {
    eventType.value = type;
  }

  void selectPriority(String p) {
    priority.value = p;
  }

  void continueToNextStep() {
    Get.toNamed(AppRoutes.eventWizard);
  }
}
