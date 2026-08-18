import '../models/quotation_model.dart';
import '../models/event_estimate_dtos.dart';

abstract class QuotationRepository {
  Future<List<QuotationItemModel>> getQuotationItems();
  Future<void> addOrUpdateEstimate(EventEstimateRequestDto payload);
}
