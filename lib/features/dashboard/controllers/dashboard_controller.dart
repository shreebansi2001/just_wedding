import 'package:get/get.dart';
import '../../../domain/models/event_model.dart';
import '../../../domain/repositories/event_repository.dart';

class DashboardController extends GetxController {
  final EventRepository _eventRepository = Get.find<EventRepository>();

  final events = <EventModel>[].obs;
  final filteredEvents = <EventModel>[].obs;
  
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  final selectedDate = Rxn<DateTime>();
  final searchQuery = ''.obs;
  
  final currentPage = 0.obs;
  final hasMoreEvents = true.obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    selectedDate.value = DateTime(now.year, now.month, now.day);
    fetchDashboardData();
  }

  Future<void> fetchDashboardData({bool loadMore = false}) async {
    if (isLoading.value && !loadMore) return;
    
    try {
      if (!loadMore) {
        isLoading.value = true;
        currentPage.value = 0;
        hasMoreEvents.value = true;
        events.clear();
      }
      
      hasError.value = false;
      
      String? toDateStr;
      if (selectedDate.value != null) {
        toDateStr = "${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}";
      }
      
      final result = await _eventRepository.getEventsFiltered(
        search: searchQuery.value,
        toDate: toDateStr,
        page: currentPage.value,
        size: 10,
      );
      
      if (result.isEmpty) {
        hasMoreEvents.value = false;
      } else {
        events.addAll(result);
        currentPage.value++;
      }
      
      _applyClientFilters();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchEvents(String query) {
    searchQuery.value = query;
    // Debounce this in a real app, but for now we just call API
    fetchDashboardData();
  }

  void selectDate(DateTime date) {
    if (selectedDate.value == date) {
      selectedDate.value = null; // Deselect
    } else {
      selectedDate.value = date;
    }
    fetchDashboardData();
  }

  void previousMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month - 1, 1);
  }

  void nextMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month + 1, 1);
  }

  void _applyClientFilters() {
    // If backend handles search/date properly, we don't need client filters,
    // but just in case, we map events to filteredEvents.
    filteredEvents.value = events;
  }
}
