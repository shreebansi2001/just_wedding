import '../../core/network/api_endpoints.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/event_dtos.dart';
import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final DioClient _dioClient;

  EventRepositoryImpl(this._dioClient);

  @override
  Future<List<EventModel>> getEventsFiltered({String? search, String? toDate, int page = 0, int size = 10}) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.eventList, // Assuming this exists or I need to add it
      data: {
        "eventStatus": null,
        "eventTypeId": null,
        "FormData": null,
        "page": page,
        "partyId": null,
        "priority": null,
        "search": search ?? "",
        "size": size,
        "sortBy": "id",
        "sortDirection": "DESC",
        "toDate": toDate,
        "userId": 13, // hardcoded as seen in payload screenshot for now
        "venueId": null
      },
    );
    
    final content = response.data['data']['content'] as List?;
    if (content == null) return [];
    
    return content.map((e) => EventModel.fromJson(e)).toList();
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
  Future<List<EventTypeMasterRequestDto>> getEventTypes({String search = "", int size = 100}) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.eventTypeList,
      data: {
        "nameEnglish": search,
        "page": 0,
        "size": size,
        "sortBy": "id",
        "sortDirection": "DESC"
      },
    );
    final data = response.data['data']['content'] as List?;
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
        "page": 0,
        "size": 100,
        "search": "",
        "sortBy": "id",
        "sortDirection": "DESC"
      },
    );
    final data = response.data['data']['content'] as List?;
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

  @override
  Future<List<PartyResponseDto>> getParties(int categoryTypeId, {String search = ""}) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.partyList,
      data: {
        "categoryId": null,
        "categoryTypeId": categoryTypeId,
        "nameEnglish": search,
        "page": 0,
        "size": 100,
        "sortBy": "id",
        "sortDirection": "DESC",
      },
    );
    final data = response.data['data']['content'] as List?;
    if (data == null) return [];
    return data.map((e) => PartyResponseDto.fromJson(e)).toList();
  }
}
