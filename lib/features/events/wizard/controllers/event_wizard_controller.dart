import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../domain/models/event_dtos.dart';
import '../../../../domain/repositories/event_repository.dart';
import 'package:dio/dio.dart';

class EventWizardController extends GetxController {
  final EventRepository _eventRepository = Get.find<EventRepository>();
  
  final currentStep = 1.obs;
  final isLoading = false.obs;
  final isEventTypesLoading = false.obs;
  
  final eventTypes = <EventTypeMasterRequestDto>[].obs;
  final eventId = 0.obs; // Stores the draft ID from Step 1

  // Step 1: Event Details
  final formKeyStep1 = GlobalKey<FormState>();
  final clientId = 'CL-2023-0891'.obs;
  
  final eventNameController = TextEditingController();
  final inquiryDateController = TextEditingController();
  final statusController = TextEditingController(text: 'INQUIRY'); // Matched to DTO
  final eventTypeController = TextEditingController(); // Added for DTO mapping
  final eventTypeId = 0.obs; // Added for DTO mapping

  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();

  final estimatedBudgetController = TextEditingController();
  final preferredVenueController = TextEditingController();
  final remarksController = TextEditingController();

  // Step 2: Client Details
  final clients = <ClientEntry>[].obs;

  // Step 3: Functions Details
  final functions = <FunctionEntry>[].obs;

  // Step 4: Budget Details (Mocked)
  // TODO: Needs a backend endpoint for category allocations
  final totalBudget = 0.0.obs;
  final cateringAllocation = 0.0.obs;
  final venueAllocation = 0.0.obs;
  final decorAllocation = 0.0.obs;

  // Step 5: Other Information Details
  final selectedOtherTab = 0.obs; // 0: Groom/Bride, 1: Other/Reference

  @override
  void onInit() {
    super.onInit();
    final today = DateFormat('MM/dd/yyyy').format(DateTime.now());
    inquiryDateController.text = today;

    clients.addAll([
      ClientEntry(prefix: 'Mr.', name: '', mobile: '', address: ''), // Groom
      ClientEntry(prefix: 'Ms.', name: '', mobile: '', address: ''), // Bride
    ]);
    
    // Default functions matching the design's hardcoded states
    functions.addAll([
      FunctionEntry(
        name: 'Wedding', 
        icon: Icons.favorite, iconBgColor: AppColors.primaryLight, iconColor: AppColors.primary, borderColor: AppColors.primary,
        date: '06/15/2024', time: '06:00 PM', venue: 'Ahmedabad', subVenue: 'Grand Ballroom', isFilledData: true,
      ),
      FunctionEntry(
        name: 'Pool Party', 
        icon: Icons.water_rounded, iconBgColor: Colors.grey.shade200, iconColor: AppColors.textSecondary, borderColor: AppColors.border,
        date: null, time: null, venue: 'Ahmedabad', subVenue: 'Poolside Deck', isFilledData: false,
      ),
    ]);
    
    _loadDropdowns();
  }
  
  Future<void> _loadDropdowns() async {
    try {
      isEventTypesLoading.value = true;
      final types = await _eventRepository.getEventTypes();
      eventTypes.assignAll(types);
      if (types.isNotEmpty) {
        eventTypeId.value = types.first.id;
        eventTypeController.text = types.first.nameEnglish ?? '';
      }
    } catch (e) {
      Get.snackbar('Warning', 'Failed to load event types');
    } finally {
      isEventTypesLoading.value = false;
    }
  }

  @override
  void onClose() {
    eventNameController.dispose();
    inquiryDateController.dispose();
    statusController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    estimatedBudgetController.dispose();
    preferredVenueController.dispose();
    remarksController.dispose();
    super.onClose();
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller, {DateTime? initialDate, DateTime? firstDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  Future<void> selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && context.mounted) {
      controller.text = picked.format(context);
    }
  }

  void addClient() {
    clients.add(ClientEntry(prefix: 'Mr.', name: '', mobile: '', address: ''));
  }

  void removeClient(int index) {
    if (clients.length > 1) {
      clients.removeAt(index);
    }
  }

  void setOtherTab(int index) {
    selectedOtherTab.value = index;
  }

  void nextStep() async {
    if (isLoading.value) return;

    if (currentStep.value == 1) {
      if (!formKeyStep1.currentState!.validate()) return;
      final success = await _saveStep1();
      if (!success) return;
    } else if (currentStep.value == 2) {
      final success = await _saveStep2();
      if (!success) return;
    } else if (currentStep.value == 3) {
      // Missing specific function form key, assuming valid for now
      final success = await _saveStep3();
      if (!success) return;
    }
    
    if (currentStep.value < 4) {
      currentStep.value++;
    } else {
      completeWizard();
    }
  }

  void previousStep() {
    if (isLoading.value) return;
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  Future<bool> _saveStep1() async {
    try {
      isLoading.value = true;
      
      final request = EventRequestDto(
        id: eventId.value,
        projectName: eventNameController.text,
        eventTypeId: eventTypeId.value,
        inquiryDate: inquiryDateController.text,
        eventStartDate: startDateController.text,
        eventStartTime: startTimeController.text,
        eventEndDate: endDateController.text,
        eventEndTime: endTimeController.text,
        budgetAmount: double.tryParse(estimatedBudgetController.text) ?? 0.0,
        venueId: 0,
        eventStatus: "INQUIRY",
        remarks: remarksController.text,
      );
      
      final response = await _eventRepository.saveEvent(request);
      final data = response['data'];
      if (data != null && data['id'] != null) {
        eventId.value = data['id'] as int;
      }
      return true;
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Failed to save basic details');
      return false;
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _saveStep2() async {
    try {
      isLoading.value = true;
      if (eventId.value == 0) return false;
      
      final groom = clients.isNotEmpty ? clients[0] : null;
      final bride = clients.length > 1 ? clients[1] : null;
      
      final otherInfo = EventOtherInfoRequestDto(
        groomName: groom?.name,
        groomContactNumber: groom?.mobile,
        brideName: bride?.name,
        brideContactNumber: bride?.mobile,
      );
      
      // Resave the event with Other Info
      final request = EventRequestDto(
        id: eventId.value,
        projectName: eventNameController.text, 
        eventTypeId: eventTypeId.value,
        inquiryDate: inquiryDateController.text, 
        eventStartDate: startDateController.text, 
        eventStartTime: startTimeController.text,
        eventEndDate: endDateController.text, 
        eventEndTime: endTimeController.text,
        budgetAmount: double.tryParse(estimatedBudgetController.text) ?? 0.0,
        venueId: 0, 
        eventStatus: "INQUIRY", 
        remarks: remarksController.text,
        eventOtherInfo: otherInfo,
      );
      
      await _eventRepository.saveEvent(request);
      return true;
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Failed to save parties');
      return false;
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _saveStep3() async {
    try {
      isLoading.value = true;
      if (eventId.value == 0) return false;
      
      final dtoList = functions.map((f) {
        return EventFunctionRequestDto(
          functionId: 1, // Need UI for this
          functionDate: f.date ?? '',
          functionTime: f.time ?? '',
          notesEnglish: '',
          venues: [
            EventFunctionVenueRequestDto(venueId: 1) // Need UI for this
          ]
        );
      }).toList();

      final request = EventFunctionListRequestDto(
        eventId: eventId.value,
        functions: dtoList,
      );
      
      await _eventRepository.saveFunctions(request);
      return true;
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? 'Failed to save functions');
      return false;
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeWizard() async {
    try {
      isLoading.value = true;
      Get.offNamed(AppRoutes.eventReady);
    } catch (e) {
      Get.snackbar('Error', 'Failed to complete wizard');
    } finally {
      isLoading.value = false;
    }
  }

  void cancel() {
    Get.back();
  }
}

/// Model for client entries in Step 2
class ClientEntry {
  String prefix;
  String name;
  String mobile;
  String address;

  ClientEntry({
    required this.prefix,
    required this.name,
    required this.mobile,
    required this.address,
  });
}

/// Model for function entries in Step 3
class FunctionEntry {
  String name;
  IconData icon;
  Color iconBgColor;
  Color iconColor;
  Color borderColor;
  String? date;
  String? time;
  String venue;
  String subVenue;
  bool isFilledData;

  FunctionEntry({
    required this.name,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.borderColor,
    this.date,
    this.time,
    required this.venue,
    required this.subVenue,
    required this.isFilledData,
  });
}
