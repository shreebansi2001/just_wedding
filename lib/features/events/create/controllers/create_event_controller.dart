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

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    _fetchEventTypes();
  }

  Future<void> _fetchEventTypes({String search = ""}) async {
    try {
      isLoadingTypes.value = true;
      final types = await _eventRepository.getEventTypes(
        search: search,
        size: 9,
      );
      eventTypes.assignAll(types);
      if (search.isEmpty &&
          types.isNotEmpty &&
          selectedEventTypeId.value == null) {
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

  // Mirrors the web app's handleCreateWorkspace: this screen only collects a
  // draft (name/type/date/priority) and never calls the API. The backend
  // requires venue + full schedule to create an event, which aren't captured
  // here - the wizard's Step 1 (which has those fields) makes the first save.
  void continueToNextStep() {
    if (eventNameController.text.isEmpty ||
        selectedEventTypeId.value == null ||
        eventDateController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all details');
      return;
    }

    Get.toNamed(
      AppRoutes.eventWizard,
      arguments: {
        'eventName': eventNameController.text,
        'eventTypeId': selectedEventTypeId.value,
        'eventDate': eventDateController.text,
        'priority': selectedPriority.value,
      },
    );
  }

  @override
  void onClose() {
    eventNameController.dispose();
    eventDateController.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}
