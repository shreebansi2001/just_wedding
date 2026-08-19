import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/quotation_model.dart';
import '../../../domain/models/event_estimate_dtos.dart';
import '../../../domain/repositories/quotation_repository.dart';

class QuotationController extends GetxController {
  final QuotationRepository _repository = Get.find<QuotationRepository>();

  final isEventInfoExpanded = true.obs;
  final isEstimateSummaryExpanded = true.obs;
  final isPaymentDetailsExpanded = true.obs;
  final isNotesExpanded = true.obs;

  final items = <QuotationItemModel>[].obs;
  final isLoading = true.obs;
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotationItems();
  }

  Future<void> fetchQuotationItems() async {
    try {
      isLoading.value = true;
      items.value = await _repository.getQuotationItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load quotation items');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveEstimate() async {
    try {
      isSaving.value = true;
      
      // Dummy payload constructed from observable fields
      // Later, this should be mapped from all the actual form inputs once they are implemented in the UI
      final payload = EventEstimateRequestDto(
        estimateDate: estimateDate.value,
        estimateType: 'MAIN', // Will need a field for this in UI
        eventId: 1, // Currently mocked, needs route argument or selection
        notes: '', // Notes field should be bound to a controller
        statusType: 'PENDING',
        functions: [], // Need mapping for items under specific functions
        payments: [], // Need payment inputs mapping
        cashAmount: 0,
        cgst: cgstPercent.value.toDouble(),
        chequeAmount: 0,
        discount: discountPercent.value.toDouble(),
        discountAmount: double.tryParse(discountAmount.value.replaceAll(',', '')),
        igst: igstPercent.value.toDouble(),
        sgst: sgstPercent.value.toDouble(),
        roundOff: 0,
        taxAmount: 0,
        userId: 1, // Should come from AuthService
      );

      await _repository.addOrUpdateEstimate(payload);
      Get.snackbar('Success', 'Estimate saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save estimate');
    } finally {
      isSaving.value = false;
    }
  }

  final eventNo = 'EST-2024-089'.obs;
  final eventName = ''.obs;
  final partyName = ''.obs;
  final venue = ''.obs;
  final estimateDate = '10/25/2024'.obs;

  Future<void> selectEstimateDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFA13253), // AppColors.primary fallback
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      estimateDate.value = "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
    }
  }
  final approvalStatus = 'Completed'.obs;
  final functionName = 'Reception'.obs;

  final discountPercent = 10.obs;
  final discountAmount = '12,000'.obs;
  final cgstPercent = 9.obs;
  final sgstPercent = 9.obs;
  final igstPercent = 0.obs;
  final taxType = 'PAN'.obs; // PAN or TDS

  final paymentMode = 'BANK_TRANSFER'.obs;

  void toggleEventInfo() => isEventInfoExpanded.value = !isEventInfoExpanded.value;
  void toggleEstimateSummary() => isEstimateSummaryExpanded.value = !isEstimateSummaryExpanded.value;
  void togglePaymentDetails() => isPaymentDetailsExpanded.value = !isPaymentDetailsExpanded.value;
  void toggleNotes() => isNotesExpanded.value = !isNotesExpanded.value;
}
