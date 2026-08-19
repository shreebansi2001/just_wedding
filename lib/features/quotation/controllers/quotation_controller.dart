import 'package:get/get.dart';
import '../../../domain/models/quotation_model.dart';
import '../../../domain/models/event_estimate_dtos.dart';
import '../../../domain/repositories/quotation_repository.dart';

class AdvancePaymentItem {
  final amount = ''.obs;
  final paymentMode = 'BANK_TRANSFER'.obs;
  final cashAccountId = (-1).obs;
  final bankId = (-1).obs;
  final paymentDate = ''.obs;
  final description = ''.obs;
}

class QuotationController extends GetxController {
  final QuotationRepository _repository = Get.find<QuotationRepository>();

  final isEventInfoExpanded = true.obs;
  final isEstimateSummaryExpanded = true.obs;
  final isPaymentDetailsExpanded = true.obs;
  final isNotesExpanded = true.obs;

  final items = <QuotationItemModel>[].obs;
  final isLoading = true.obs;
  final isSaving = false.obs;

  final advancePayments = <AdvancePaymentItem>[].obs;
  final bankAccounts = <dynamic>[].obs;
  final cashAccounts = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotationItems();
    fetchBankAccounts();
    fetchCashAccounts();
  }

  void addAdvancePayment() {
    advancePayments.add(AdvancePaymentItem());
  }

  void removeAdvancePayment(int index) {
    advancePayments.removeAt(index);
  }

  Future<void> fetchBankAccounts() async {
    try {
      final payload = {
        "isPrimary": true,
        "page": 0,
        "search": "",
        "size": 100,
        "sortBy": "",
        "sortDirection": "",
        "userId": 0
      };
      bankAccounts.value = await _repository.getBankAccounts(payload);
    } catch (e) {
      print('Error fetching bank accounts: $e');
    }
  }

  Future<void> fetchCashAccounts() async {
    try {
      final payload = {
        "isPrimary": true,
        "page": 0,
        "search": "",
        "size": 100,
        "sortBy": "",
        "sortDirection": "",
        "userId": 0
      };
      cashAccounts.value = await _repository.getCashAccounts(payload);
    } catch (e) {
      print('Error fetching cash accounts: $e');
    }
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
      
      final payload = EventEstimateRequestDto(
        estimateDate: estimateDate.value,
        estimateType: estimateType.value,
        eventId: -1,
        notes: '',
        statusType: 'PENDING',
        functions: [],
        payments: advancePayments.map((p) => EventEstimatePaymentRequestDto(
          amount: double.tryParse(p.amount.value) ?? 0.0,
          bankId: p.bankId.value,
          cashAccountId: p.cashAccountId.value,
          description: p.description.value,
          id: 0,
          mode: p.paymentMode.value,
          paymentDate: p.paymentDate.value,
        )).toList(),
        cashAmount: double.tryParse(cashPaymentAmount.value.replaceAll(',', '')) ?? 0.0,
        cgst: cgstPercent.value.toDouble(),
        chequeAmount: double.tryParse(chequePaymentAmount.value.replaceAll(',', '')) ?? 0.0,
        discount: discountPercent.value.toDouble(),
        discountAmount: double.tryParse(discountAmount.value.replaceAll(',', '')) ?? 0.0,
        igst: igstPercent.value.toDouble(),
        sgst: sgstPercent.value.toDouble(),
        roundOff: double.tryParse(roundOffAmount.value.replaceAll(',', '')) ?? 0.0,
        taxAmount: 0,
        userId: 1,
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
  final estimateType = 'MAIN'.obs; // MAIN or OTHER
  final approvalStatus = 'Completed'.obs;
  final functionName = 'Reception'.obs;

  final discountPercent = 10.obs;
  final discountAmount = '12500'.obs;
  final cgstPercent = 9.obs;
  final sgstPercent = 9.obs;
  final igstPercent = 0.obs;
  final taxType = 'TDS'.obs; // TDS or TCS
  
  final tdsAmount = '0'.obs;
  final roundOffAmount = '0'.obs;
  final cashPaymentAmount = '0'.obs;
  final chequePaymentAmount = '0'.obs;

  final paymentMode = 'BANK_TRANSFER'.obs;

  void toggleEventInfo() => isEventInfoExpanded.value = !isEventInfoExpanded.value;
  void toggleEstimateSummary() => isEstimateSummaryExpanded.value = !isEstimateSummaryExpanded.value;
  void togglePaymentDetails() => isPaymentDetailsExpanded.value = !isPaymentDetailsExpanded.value;
  void toggleNotes() => isNotesExpanded.value = !isNotesExpanded.value;
}
