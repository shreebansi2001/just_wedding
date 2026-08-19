import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../domain/models/event_dtos.dart';
import '../../../../domain/repositories/event_repository.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class CreateEventController extends GetxController {
  final EventRepository _eventRepository = Get.find<EventRepository>();

  // Form Fields matching screenshot
  final eventNameController = TextEditingController();
  final eventDateController = TextEditingController();
  final selectedEventTypeId = Rxn<int>();
  final selectedPriority = 'Med'.obs; // High, Med, Low

  // Data Lists
  final eventTypes = <EventTypeMasterRequestDto>[].obs;
  final isLoadingTypes = true.obs;
  final isCreating = false.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    _fetchEventTypes();
  }

  Future<void> _fetchEventTypes({String search = ""}) async {
    try {
      isLoadingTypes.value = true;
      final types = await _eventRepository.getEventTypes(search: search, size: 9);
      eventTypes.assignAll(types);
      if (search.isEmpty && types.isNotEmpty && selectedEventTypeId.value == null) {
        // optionally auto select first if needed, but maybe not required for grid
      }
    } catch (e) {
      debugPrint('Failed to load event types: $e');
    } finally {
      isLoadingTypes.value = false;
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _fetchEventTypes(search: query);
    });
  }

  void selectType(int? typeId) {
    selectedEventTypeId.value = typeId;
  }

  void setPriority(String priority) {
    selectedPriority.value = priority;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      eventDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> continueToNextStep() async {
    if (eventNameController.text.isEmpty || selectedEventTypeId.value == null || eventDateController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all details');
      return;
    }

    try {
      isCreating.value = true;
      
      final request = EventRequestDto(
        id: 0,
        projectName: eventNameController.text,
        eventTypeId: selectedEventTypeId.value!,
        inquiryDate: DateFormat('dd/MM/yyyy').format(DateTime.now()), // Set inquiry date
        eventStartDate: eventDateController.text,
        eventStartTime: "",
        eventEndDate: "",
        eventEndTime: "",
        eventStatus: "INQUIRY",
        priority: selectedPriority.value,
      );

      final response = await _eventRepository.saveEvent(request);
      final data = response['data'];
      if (data != null && data['id'] != null) {
        final eventId = data['id'] as int;
        
        Get.toNamed(AppRoutes.eventWizard, arguments: {
          'eventId': eventId,
          'eventName': eventNameController.text,
          'eventTypeId': selectedEventTypeId.value,
          'eventDate': eventDateController.text,
          'priority': selectedPriority.value,
        });
      } else {
        Get.snackbar('Error', 'Failed to retrieve event ID');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create workspace: $e');
    } finally {
      isCreating.value = false;
    }
  }

  @override
  void onClose() {
    eventNameController.dispose();
    eventDateController.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}
