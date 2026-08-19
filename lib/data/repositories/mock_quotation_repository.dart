import '../../domain/models/quotation_model.dart';
import '../../domain/models/event_estimate_dtos.dart';
import '../../domain/repositories/quotation_repository.dart';

class MockQuotationRepository implements QuotationRepository {
  @override
  Future<List<QuotationItemModel>> getQuotationItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      QuotationItemModel(
        id: '1',
        title: 'Photography - Candid',
        description: '2 Senior Photographers, full day coverage',
        quantity: 2,
        days: 1,
        rate: 25000,
        amount: 50000,
      ),
      QuotationItemModel(
        id: '2',
        title: 'Cinematography',
        description: 'Traditional & Cinematic video coverage',
        quantity: 2,
        days: 1,
        rate: 35000,
        amount: 70000,
      ),
    ];
  }

  @override
  Future<void> addOrUpdateEstimate(EventEstimateRequestDto payload) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<dynamic>> getBankAccounts(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  @override
  Future<List<dynamic>> getCashAccounts(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
}
