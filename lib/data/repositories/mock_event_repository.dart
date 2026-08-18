import 'dart:math';
import '../../domain/models/event_model.dart';
import '../../domain/models/event_dtos.dart';
import '../../domain/repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  final List<EventModel> _events = [
    EventModel(
      id: '1',
      title: 'Rahul & Priya Wedding',
      date: '18 Aug 2026',
      time: '05:00 PM',
      location: 'Ahmedabad, Gujarat',
      tag: 'Wedding',
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=200&q=80',
    ),
    EventModel(
      id: '2',
      title: 'Corporate Summit 2026',
      date: '22 Aug 2026',
      time: '10:00 AM',
      location: 'Mumbai, Maharashtra',
      tag: 'Corporate',
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=200&q=80',
    ),
    EventModel(
      id: '3',
      title: 'Sneha\'s Birthday Party',
      date: '25 Aug 2026',
      time: '07:00 PM',
      location: 'Surat, Gujarat',
      tag: 'Birthday',
      imageUrl: 'https://images.unsplash.com/photo-1530103862676-de8892b07439?auto=format&fit=crop&w=200&q=80',
    ),
  ];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<List<EventModel>> getEvents() async {
    await _simulateDelay();
    return List.from(_events);
  }

  @override
  Future<EventModel> getEventById(String id) async {
    await _simulateDelay();
    final event = _events.firstWhere((e) => e.id == id, orElse: () => throw Exception('Event not found'));
    return event;
  }

  @override
  Future<EventModel> createEvent(EventModel event) async {
    await _simulateDelay();
    final newEvent = event.copyWith(id: Random().nextInt(10000).toString());
    _events.add(newEvent);
    return newEvent;
  }

  @override
  Future<EventModel> updateEvent(EventModel event) async {
    await _simulateDelay();
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index == -1) throw Exception('Event not found');
    _events[index] = event;
    return event;
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _simulateDelay();
    _events.removeWhere((e) => e.id == id);
  }

  // Phase 2 specific methods stubbed
  @override
  Future<List<EventTypeMasterRequestDto>> getEventTypes() async {
    return [
      EventTypeMasterRequestDto(id: 1, nameEnglish: 'Wedding'),
      EventTypeMasterRequestDto(id: 2, nameEnglish: 'Corporate'),
    ];
  }

  @override
  Future<Map<String, dynamic>> saveEvent(EventRequestDto request) async {
    return {
      "status": "SUCCESS",
      "message": "Event saved successfully",
      "data": {"id": 12345}
    };
  }

  @override
  Future<List<VenueResponseDto>> getVenues() async {
    return [];
  }

  @override
  Future<List<FunctionResponseDto>> getFunctions() async {
    return [];
  }

  @override
  Future<void> saveFunctions(EventFunctionListRequestDto request) async {
  }
}
