import '../models/location_models.dart';

abstract class LocationRepository {
  Future<List<LocationModel>> getStates();
  Future<List<LocationModel>> getCities(int stateId);
}
