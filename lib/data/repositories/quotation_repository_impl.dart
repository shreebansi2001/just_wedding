import '../../domain/models/quotation_model.dart';
import '../../domain/models/event_estimate_dtos.dart';
import '../../domain/repositories/quotation_repository.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/api_endpoints.dart';

class QuotationRepositoryImpl implements QuotationRepository {
  final DioClient _dioClient;

  QuotationRepositoryImpl(this._dioClient);

  @override
  Future<List<QuotationItemModel>> getQuotationItems() async {
    // Current mock implementation kept for UI display purposes as the 
    // real GET endpoint for quotation items isn't clear from current context.
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
    final formData = payload.toFormData();

    final response = await _dioClient.dio.post(
      ApiEndpoints.eventEstimateAddUpdate,
      data: formData,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save estimate');
    }
  }
}
