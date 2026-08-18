import '../models/event_model.dart';
import '../models/event_dtos.dart';

abstract class EventRepository {
  Future<List<EventModel>> getEventsFiltered({String? search, String? toDate, int page = 0, int size = 10});
  Future<EventModel> getEventById(String id);
  Future<EventModel> createEvent(EventModel event);
  Future<EventModel> updateEvent(EventModel event);
  Future<void> deleteEvent(String id);
  
  // Phase 2 specific methods
  Future<List<EventTypeMasterRequestDto>> getEventTypes({String search = "", int size = 100});
  Future<Map<String, dynamic>> saveEvent(EventRequestDto request);
  Future<List<VenueResponseDto>> getVenues();
  Future<List<FunctionResponseDto>> getFunctions();
  Future<void> saveFunctions(EventFunctionListRequestDto request);
  Future<List<PartyResponseDto>> getParties(int categoryTypeId, {String search = ""});
}
