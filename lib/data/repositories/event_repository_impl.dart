import '../../core/network/api_endpoints.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/event_dtos.dart';
import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final DioClient _dioClient;

  EventRepositoryImpl(this._dioClient);

  @override
  Future<List<EventModel>> getEvents() async {
    // Left as mock or empty for now as Phase 2 only focuses on Wizard steps
    return [];
  }

  @override
  Future<EventModel> getEventById(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<EventModel> createEvent(EventModel event) async {
    throw UnimplementedError('Use saveEvent for Phase 2 API integration');
  }

  @override
  Future<EventModel> updateEvent(EventModel event) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEvent(String id) async {
    throw UnimplementedError();
  }

  // Phase 2 specific methods
  @override
  Future<List<EventTypeMasterRequestDto>> getEventTypes() async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.eventTypeList,
      data: {
        "nameEnglish": "",
        "page": 0,
        "size": 100, // Fetch up to 100 event types for dropdown
        "sortBy": "nameEnglish",
        "sortDirection": "asc"
      },
    );
    final data = response.data['data'] as List?;
    if (data == null) return [];
    return data.map((e) => EventTypeMasterRequestDto.fromJson(e)).toList();
  }

  @override
  Future<Map<String, dynamic>> saveEvent(EventRequestDto request) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.eventAddUpdate,
      data: request.toJson(),
    );
    return response.data;
  }

  @override
  Future<List<VenueResponseDto>> getVenues() async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.venueList,
      data: {
        "nameEnglish": "",
        "venueType": "",
        "cityId": 0,
        "stateId": 0,
        "isActive": true,
        "page": 0,
        "size": 100,
        "sortBy": "nameEnglish",
        "sortDirection": "asc"
      },
    );
    final data = response.data['data'] as List?;
    if (data == null) return [];
    return data.map((e) => VenueResponseDto.fromJson(e)).toList();
  }

  @override
  Future<List<FunctionResponseDto>> getFunctions() async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.functionList,
      data: {
        "nameEnglish": "",
        "page": 0,
        "size": 100,
        "sortBy": "nameEnglish",
        "sortDirection": "asc"
      },
    );
    final data = response.data['data'] as List?;
    if (data == null) return [];
    return data.map((e) => FunctionResponseDto.fromJson(e)).toList();
  }

  @override
  Future<void> saveFunctions(EventFunctionListRequestDto request) async {
    await _dioClient.dio.post(
      ApiEndpoints.eventFunctionAddUpdateList,
      data: request.toJson(),
    );
  }
}
