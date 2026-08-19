import '../models/quotation_model.dart';
import '../models/event_estimate_dtos.dart';

abstract class QuotationRepository {
  Future<List<QuotationItemModel>> getQuotationItems();
  Future<void> addOrUpdateEstimate(EventEstimateRequestDto payload);
  Future<List<dynamic>> getBankAccounts(Map<String, dynamic> payload);
  Future<List<dynamic>> getCashAccounts(Map<String, dynamic> payload);
}
