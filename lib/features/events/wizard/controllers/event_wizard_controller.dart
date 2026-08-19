import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/routes/app_routes.dart';
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
  final statusController = TextEditingController(
    text: 'INQUIRY',
  ); // Matched to DTO
  final eventTypeController = TextEditingController(); // Added for DTO mapping
  final eventTypeId = 0.obs; // Added for DTO mapping
  final priority = 'Med'.obs;
  final statusOptions = ['Inquiry', 'Confirmed', 'Cancelled'].obs;

  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();

  final estimatedBudgetController = TextEditingController();
  final preferredVenueController = TextEditingController();
  final selectedVenueId = Rxn<int>();
  final remarksController = TextEditingController();

  // Step 2: Client Details
  final clients = <ClientEntry>[].obs;
  final parties = <PartyResponseDto>[].obs;
  final isPartiesLoading = false.obs;

  // Step 3: Functions Details
  final functions = <FunctionEntry>[].obs;
  final venues = <VenueResponseDto>[].obs;
  final isVenuesLoading = false.obs;
  final functionTypes = <FunctionResponseDto>[].obs;
  final isFunctionTypesLoading = false.obs;
  final functionSearchQuery = ''.obs;

  // Step 4: Other Information Details
  final selectedOtherTab = 0.obs; // 0: Groom/Bride, 1: Other/Reference
  final otherInfoId = Rxn<int>();

  final groomNameController = TextEditingController();
  final groomFatherNameController = TextEditingController();
  final groomContactNumberController = TextEditingController();
  final groomInstaIdController = TextEditingController();
  final groomBirthdateController = TextEditingController();
  final groomPhotographerNameController = TextEditingController();
  final groomPhotographerContactController = TextEditingController();

  final brideNameController = TextEditingController();
  final brideFatherNameController = TextEditingController();
  final brideContactNumberController = TextEditingController();
  final brideInstaIdController = TextEditingController();
  final brideBirthdateController = TextEditingController();
  final bridePhotographerNameController = TextEditingController();
  final bridePhotographerContactController = TextEditingController();

  final referencePhotographerNameController = TextEditingController();
  final referencePhotographerContactController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    inquiryDateController.text = today;

    if (Get.arguments != null) {
      eventId.value = Get.arguments['eventId'] ?? 0;
      eventNameController.text = Get.arguments['eventName'] ?? '';

      final evId = Get.arguments['eventTypeId'];
      if (evId != null) eventTypeId.value = evId;

      startDateController.text = Get.arguments['eventDate'] ?? '';
      priority.value = Get.arguments['priority'] ?? 'Med';
    }

    clients.addAll([
      ClientEntry(prefix: 'Mr.', partyId: null, mobile: '', address: ''),
    ]);

    _loadDropdowns();
  }

  Future<void> _loadDropdowns() async {
    _fetchEventTypes();
    _fetchParties();
    _fetchVenues();
    _fetchFunctionTypes();
  }

  Future<void> _fetchVenues() async {
    try {
      isVenuesLoading.value = true;
      final list = await _eventRepository.getVenues();
      venues.assignAll(list);
    } catch (e) {
      Get.snackbar('Warning', 'Failed to load venues');
    } finally {
      isVenuesLoading.value = false;
    }
  }

  Future<void> _fetchFunctionTypes() async {
    try {
      isFunctionTypesLoading.value = true;
      final list = await _eventRepository.getFunctions();
      functionTypes.assignAll(list);
    } catch (e) {
      Get.snackbar('Warning', 'Failed to load function types');
    } finally {
      isFunctionTypesLoading.value = false;
    }
  }

  Future<void> _fetchEventTypes() async {
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

  Future<void> _fetchParties() async {
    try {
      isPartiesLoading.value = true;
      final list = await _eventRepository.getParties(6);
      parties.assignAll(list);
    } catch (e) {
      debugPrint('Failed to load parties: $e');
    } finally {
      isPartiesLoading.value = false;
    }
  }

  Future<List<PartyResponseDto>> searchParties(String query) async {
    if (query.isEmpty) return parties;
    try {
      return await _eventRepository.getParties(6, search: query);
    } catch (e) {
      debugPrint('Failed to search parties: $e');
      return [];
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

    groomNameController.dispose();
    groomFatherNameController.dispose();
    groomContactNumberController.dispose();
    groomInstaIdController.dispose();
    groomBirthdateController.dispose();
    groomPhotographerNameController.dispose();
    groomPhotographerContactController.dispose();

    brideNameController.dispose();
    brideFatherNameController.dispose();
    brideContactNumberController.dispose();
    brideInstaIdController.dispose();
    brideBirthdateController.dispose();
    bridePhotographerNameController.dispose();
    bridePhotographerContactController.dispose();

    referencePhotographerNameController.dispose();
    referencePhotographerContactController.dispose();
    super.onClose();
  }

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && context.mounted) {
      controller.text = _formatTime(picked);
    }
  }

  // Matches the web app's dayjs "hh:mm A" format exactly (zero-padded hour,
  // uppercase AM/PM) - TimeOfDay.format(context) is locale-dependent and
  // doesn't zero-pad, which the backend's strict time parser rejects.
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  void addClient() {
    clients.add(
      ClientEntry(prefix: 'Mr.', partyId: null, mobile: '', address: ''),
    );
  }

  void removeClient(int index) {
    if (clients.length > 1) {
      clients.removeAt(index);
    }
  }

  void addFunctionRow() {
    functions.add(FunctionEntry());
  }

  void removeFunctionRow(FunctionEntry entry) {
    functions.remove(entry);
  }

  void selectFunctionType(FunctionEntry entry, int functionTypeId) {
    final type = functionTypes.firstWhereOrNull((f) => f.id == functionTypeId);
    if (type == null) return;
    entry.functionId = type.id;
    entry.name = type.nameEnglish ?? '';
    // Auto-fill the time from the function master's default, matching the
    // web app (Functiondetails.jsx: time: opt?.timeFrom || f.time).
    if ((entry.time == null || entry.time!.isEmpty) && type.timeFrom != null) {
      entry.time = type.timeFrom;
    }
    functions.refresh();
  }

  void selectFunctionVenue(FunctionEntry entry, int venueId) {
    final v = venues.firstWhereOrNull((e) => e.id == venueId);
    if (v == null) return;
    entry.venueId = v.id;
    entry.venue = v.nameEnglish ?? '';
    entry.subVenueIds =
        []; // reset sub-venue selection when venue changes, matching web
    entry.venueRecordId = null;
    functions.refresh();
  }

  void toggleSubVenue(FunctionEntry entry, int subVenueId) {
    if (entry.subVenueIds.contains(subVenueId)) {
      entry.subVenueIds = entry.subVenueIds
          .where((id) => id != subVenueId)
          .toList();
    } else {
      entry.subVenueIds = [...entry.subVenueIds, subVenueId];
    }
    functions.refresh();
  }

  void updateFunctionNotes(FunctionEntry entry, String notes) {
    entry.notesEnglish = notes;
    functions.refresh();
  }

  Future<void> pickFunctionDate(
    BuildContext context,
    FunctionEntry entry,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      entry.date = DateFormat('dd/MM/yyyy').format(picked);
      functions.refresh();
    }
  }

  Future<void> pickFunctionTime(
    BuildContext context,
    FunctionEntry entry,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && context.mounted) {
      entry.time = _formatTime(picked);
      functions.refresh();
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

  String? _orNull(String text) => text.trim().isEmpty ? null : text.trim();

  /// Maps Step 2's prefix dropdown to the backend's Title enum (MR/MRS/MS/DR/ER),
  /// mirroring the web app's TITLE_MAP in buildEventPayload.js.
  static const _titleEnumMap = {
    'mr.': 'MR',
    'mrs.': 'MRS',
    'ms.': 'MS',
    'dr.': 'DR',
  };

  String _backendTitle() {
    final mainClient = clients.isNotEmpty ? clients[0] : null;
    final key = mainClient?.prefix.trim().toLowerCase();
    return _titleEnumMap[key] ?? 'MR';
  }

  List<EventFunctionRequestDto> _buildFunctionsPayload() {
    return functions
        .where((f) => f.functionId != null && f.venueId != null)
        .map(
          (f) => EventFunctionRequestDto(
            id: f.recordId ?? 0,
            functionId: f.functionId!,
            functionDate: f.date ?? '',
            functionTime: f.time ?? '',
            notesEnglish: f.notesEnglish,
            venues: [
              EventFunctionVenueRequestDto(
                id: f.venueRecordId ?? 0,
                venueId: f.venueId!,
                subVenueId: f.subVenueIds,
              ),
            ],
          ),
        )
        .toList();
  }

  EventOtherInfoRequestDto _buildOtherInfoPayload() {
    final isGroomBride = selectedOtherTab.value == 0;
    return EventOtherInfoRequestDto(
      id: otherInfoId.value,
      photographerDetailType: isGroomBride ? 'GROOM_BRIDE' : 'OTHER_REFERENCE',
      groomName: isGroomBride ? _orNull(groomNameController.text) : null,
      groomFatherName: isGroomBride
          ? _orNull(groomFatherNameController.text)
          : null,
      groomContactNumber: isGroomBride
          ? _orNull(groomContactNumberController.text)
          : null,
      groomInstaId: isGroomBride ? _orNull(groomInstaIdController.text) : null,
      groomBirthdate: isGroomBride
          ? _orNull(groomBirthdateController.text)
          : null,
      groomPhotographerName: isGroomBride
          ? _orNull(groomPhotographerNameController.text)
          : _orNull(referencePhotographerNameController.text),
      groomPhotographerContactNumber: isGroomBride
          ? _orNull(groomPhotographerContactController.text)
          : _orNull(referencePhotographerContactController.text),
      brideName: isGroomBride ? _orNull(brideNameController.text) : null,
      brideFatherName: isGroomBride
          ? _orNull(brideFatherNameController.text)
          : null,
      brideContactNumber: isGroomBride
          ? _orNull(brideContactNumberController.text)
          : null,
      brideInstaId: isGroomBride ? _orNull(brideInstaIdController.text) : null,
      brideBirthdate: isGroomBride
          ? _orNull(brideBirthdateController.text)
          : null,
      bridePhotographerName: isGroomBride
          ? _orNull(bridePhotographerNameController.text)
          : null,
      bridePhotographerContactNumber: isGroomBride
          ? _orNull(bridePhotographerContactController.text)
          : null,
    );
  }

  /// Builds the full accumulated event state, exactly like the web app's
  /// buildEventPayload.js: every step resends the whole record (name, venue,
  /// client, functions, other-info together) rather than just its own slice,
  /// since the backend does not merge partial add-update payloads.
  EventRequestDto _buildEventRequest() {
    final mainClient = clients.isNotEmpty ? clients[0] : null;
    return EventRequestDto(
      id: eventId.value,
      projectName: eventNameController.text,
      eventTypeId: eventTypeId.value,
      inquiryDate: inquiryDateController.text,
      eventStartDate: startDateController.text,
      eventStartTime: startTimeController.text,
      eventEndDate: endDateController.text,
      eventEndTime: endTimeController.text,
      budgetAmount: double.tryParse(estimatedBudgetController.text) ?? 0.0,
      venueId: selectedVenueId.value ?? 0,
      eventStatus: _backendEventStatus(),
      remarks: remarksController.text,
      priority: priority.value.toUpperCase(),
      title: _backendTitle(),
      partyId: mainClient?.partyId,
      eventFunctions: _buildFunctionsPayload(),
      eventOtherInfo: _buildOtherInfoPayload(),
    );
  }

  Future<bool> _saveCurrentState(String failureMessage) async {
    try {
      isLoading.value = true;
      if (eventId.value == 0) return false;
      final response = await _eventRepository.saveEvent(_buildEventRequest());
      _applyEventResponse(response);
      return true;
    } on DioException catch (e) {
      Get.snackbar('Error', e.error?.toString() ?? failureMessage);
      return false;
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Captures the backend-assigned ids for the event itself and its one-to-one
  /// (eventOtherInfo) / one-to-many (eventFunctions) children from the
  /// add-update response, so the next save updates those rows instead of
  /// inserting duplicates (which otherwise 500s on a one-to-one constraint).
  void _applyEventResponse(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is! Map) return;

    final id = data['id'];
    if (id is int) eventId.value = id;

    // Confirmed from a live response: the backend echoes this back as
    // "otherInfo", not "eventOtherInfo" (the request field name) - it renames
    // several fields on the way out (e.g. eventNameEnglish, venueNameEnglish).
    final otherInfo = data['otherInfo'] ?? data['eventOtherInfo'];
    if (otherInfo is Map && otherInfo['id'] is int) {
      otherInfoId.value = otherInfo['id'] as int;
    }

    final returnedFunctions = data['eventFunctions'] ?? data['functions'];
    if (returnedFunctions is List) {
      for (final rf in returnedFunctions) {
        if (rf is! Map) continue;
        final match = functions.firstWhereOrNull(
          (f) => f.functionId == rf['functionId'],
        );
        if (match == null) continue;
        if (rf['id'] is int) match.recordId = rf['id'] as int;
        final venuesJson = rf['venues'];
        if (venuesJson is List && venuesJson.isNotEmpty) {
          final firstVenue = venuesJson.first;
          if (firstVenue is Map && firstVenue['id'] is int) {
            match.venueRecordId = firstVenue['id'] as int;
          }
        }
      }
    }
  }

  Future<bool> _saveStep4() =>
      _saveCurrentState('Failed to save other details');

  void previousStep() {
    if (isLoading.value) return;
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  /// Maps the UI's display labels to the backend's EventStatus enum
  /// (INQUIRY, CONFIRM, CANCEL, TENTATIVE) - the UI label and enum name diverge
  /// for "Confirmed"/"Cancelled" so a blind toUpperCase() would send an invalid value.
  static const _statusEnumMap = {
    'inquiry': 'INQUIRY',
    'confirmed': 'CONFIRM',
    'cancelled': 'CANCEL',
    'tentative': 'TENTATIVE',
  };

  String _backendEventStatus() {
    final key = statusController.text.trim().toLowerCase();
    return _statusEnumMap[key] ?? statusController.text.toUpperCase();
  }

  Future<bool> _saveStep1() async {
    try {
      isLoading.value = true;
      final response = await _eventRepository.saveEvent(_buildEventRequest());
      _applyEventResponse(response);
      return true;
    } on DioException catch (e) {
      Get.snackbar(
        'Error',
        e.error?.toString() ?? 'Failed to save basic details',
      );
      return false;
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _saveStep2() => _saveCurrentState('Failed to save parties');

  Future<bool> _saveStep3() => _saveCurrentState('Failed to save functions');

  Future<void> completeWizard() async {
    if (isLoading.value) return;
    final success = await _saveStep4();
    if (!success) return;
    Get.offNamed(AppRoutes.eventReady);
  }

  void cancel() {
    Get.back();
  }
}

/// Model for client entries in Step 2
class ClientEntry {
  String prefix;
  int? partyId;
  String mobile;
  String address;

  ClientEntry({
    required this.prefix,
    this.partyId,
    required this.mobile,
    required this.address,
  });
}

/// Model for function entries in Step 3
/// Model for a single function row in Step 3 - mirrors the web app's
/// emptyFunctionRow() in Functiondetails.jsx.
class FunctionEntry {
  String name;
  int? functionId;
  int? venueId;
  String venue;
  List<int> subVenueIds;
  String? date;
  String? time;
  String notesEnglish;

  // Backend row ids, captured from the add-update response so resaving this
  // function updates the existing rows instead of inserting duplicates -
  // mirrors the web app's fn.functionRecordId / fn.venueRecordId.
  int? recordId;
  int? venueRecordId;

  FunctionEntry({
    this.name = '',
    this.functionId,
    this.venueId,
    this.venue = '',
    List<int>? subVenueIds,
    this.date,
    this.time,
    this.notesEnglish = '',
    this.recordId,
    this.venueRecordId,
  }) : subVenueIds = subVenueIds ?? [];
}
