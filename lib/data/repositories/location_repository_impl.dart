import '../../domain/models/location_models.dart';
import '../../domain/repositories/location_repository.dart';
import '../../core/network/dio_client.dart';
import 'package:dio/dio.dart';

class LocationRepositoryImpl implements LocationRepository {
  final DioClient _dioClient;

  LocationRepositoryImpl(this._dioClient);

  @override
  Future<List<LocationModel>> getStates() async {
    try {
      final response = await _dioClient.dio.post('/v1/api/state/list', data: {});
      final data = response.data['data']['content'] as List;
      return data.map((e) => LocationModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to fetch states');
    }
  }

  @override
  Future<List<LocationModel>> getCities(int stateId) async {
    try {
      final response = await _dioClient.dio.post('/v1/api/city/list', data: {
        'stateId': stateId,
      });
      final data = response.data['data']['content'] as List;
      return data.map((e) => LocationModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to fetch cities');
    }
  }
}
