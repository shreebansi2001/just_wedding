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
    try {
      final data = payload.toFormData();
      final response = await _dioClient.dio.post(
        ApiEndpoints.eventEstimateAddUpdate,
        data: data,
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to add or update estimate');
      }
    } catch (e) {
      throw Exception('Failed to add or update estimate: $e');
    }
  }

  @override
  Future<List<dynamic>> getBankAccounts(Map<String, dynamic> payload) async {
    try {
      final response = await _dioClient.dio.post(ApiEndpoints.bankList, data: payload);
      // Assuming response data holds the list in 'data' -> 'content' or just 'data'
      if (response.data != null && response.data['data'] != null) {
        if (response.data['data'] is Map && response.data['data']['content'] != null) {
          return response.data['data']['content'];
        } else if (response.data['data'] is List) {
          return response.data['data'];
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<dynamic>> getCashAccounts(Map<String, dynamic> payload) async {
    try {
      final response = await _dioClient.dio.post(ApiEndpoints.cashAccountList, data: payload);
      if (response.data != null && response.data['data'] != null) {
        if (response.data['data'] is Map && response.data['data']['content'] != null) {
          return response.data['data']['content'];
        } else if (response.data['data'] is List) {
          return response.data['data'];
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
