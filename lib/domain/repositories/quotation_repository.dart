import '../models/quotation_model.dart';

abstract class QuotationRepository {
  Future<List<QuotationItemModel>> getQuotationItems();
}
