import '../models/event_model.dart';
import '../models/event_dtos.dart';

abstract class EventRepository {
  Future<List<EventModel>> getEvents();
  Future<EventModel> getEventById(String id);
  Future<EventModel> createEvent(EventModel event);
  Future<EventModel> updateEvent(EventModel event);
  Future<void> deleteEvent(String id);
  
  // Phase 2 specific methods
  Future<List<EventTypeMasterRequestDto>> getEventTypes();
  Future<Map<String, dynamic>> saveEvent(EventRequestDto request);
  Future<List<VenueResponseDto>> getVenues();
  Future<List<FunctionResponseDto>> getFunctions();
  Future<void> saveFunctions(EventFunctionListRequestDto request);
}
