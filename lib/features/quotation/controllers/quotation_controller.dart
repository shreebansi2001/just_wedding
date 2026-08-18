import 'package:get/get.dart';
import '../../../domain/models/quotation_model.dart';
import '../../../domain/repositories/quotation_repository.dart';

class QuotationController extends GetxController {
  final QuotationRepository _repository = Get.find<QuotationRepository>();

  final isEventInfoExpanded = true.obs;
  final isEstimateSummaryExpanded = true.obs;
  final isPaymentDetailsExpanded = true.obs;
  final isNotesExpanded = true.obs;

  final items = <QuotationItemModel>[].obs;
  final isLoading = true.obs;

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

  final eventNo = 'EST-2024-089'.obs;
  final eventName = ''.obs;
  final partyName = ''.obs;
  final venue = ''.obs;
  final estimateDate = '10/25/2024'.obs;
  final approvalStatus = 'Completed'.obs;
  final functionName = 'Reception'.obs;

  final discountPercent = 10.obs;
  final discountAmount = '12,000'.obs;
  final cgstPercent = 9.obs;
  final sgstPercent = 9.obs;
  final igstPercent = 0.obs;
  final taxType = 'PAN'.obs; // PAN or TDS

  void toggleEventInfo() => isEventInfoExpanded.value = !isEventInfoExpanded.value;
  void toggleEstimateSummary() => isEstimateSummaryExpanded.value = !isEstimateSummaryExpanded.value;
  void togglePaymentDetails() => isPaymentDetailsExpanded.value = !isPaymentDetailsExpanded.value;
  void toggleNotes() => isNotesExpanded.value = !isNotesExpanded.value;
}
