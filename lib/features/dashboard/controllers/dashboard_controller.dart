import 'package:get/get.dart';
import '../../../domain/models/event_model.dart';
import '../../../domain/repositories/event_repository.dart';

class DashboardController extends GetxController {
  final EventRepository _eventRepository = Get.find<EventRepository>();

  final events = <EventModel>[].obs;
  final filteredEvents = <EventModel>[].obs;
  
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      
      final result = await _eventRepository.getEvents();
      events.value = result;
      filteredEvents.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      filteredEvents.value = events;
      return;
    }
    final lowerQuery = query.toLowerCase();
    filteredEvents.value = events.where((e) {
      return e.title.toLowerCase().contains(lowerQuery) ||
             e.location.toLowerCase().contains(lowerQuery) ||
             e.tag.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
