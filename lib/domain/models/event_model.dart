class EventModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String tag;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.tag,
    required this.imageUrl,
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? date,
    String? time,
    String? location,
    String? tag,
    String? imageUrl,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      tag: tag ?? this.tag,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
