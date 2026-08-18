class EventTypeMasterRequestDto {
  final int id;
  final String? nameEnglish;
  final String? imgPath;

  EventTypeMasterRequestDto({required this.id, this.nameEnglish, this.imgPath});

  factory EventTypeMasterRequestDto.fromJson(Map<String, dynamic> json) {
    return EventTypeMasterRequestDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
      imgPath: json['imgPath'],
    );
  }
}

class EventRequestDto {
  final String? title;
  final String projectName;
  final int eventTypeId;
  final String inquiryDate;
  final String eventStartDate;
  final String eventStartTime;
  final String eventEndDate;
  final String eventEndTime;
  final double budgetAmount;
  final int venueId;
  final String? priority;
  final String eventStatus;
  final String remarks;
  final int id;
  final int userId;
  final int? partyId;
  final EventOtherInfoRequestDto? eventOtherInfo;
  final List<EventFunctionRequestDto>? eventFunctions;

  EventRequestDto({
    this.title,
    required this.projectName,
    required this.eventTypeId,
    required this.inquiryDate,
    required this.eventStartDate,
    required this.eventStartTime,
    required this.eventEndDate,
    required this.eventEndTime,
    this.budgetAmount = 0.0,
    this.venueId = 0,
    this.priority,
    required this.eventStatus,
    this.remarks = '',
    this.id = 0,
    this.userId = 0,
    this.partyId,
    this.eventOtherInfo,
    this.eventFunctions,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      if (title != null) 'title': title,
      'projectName': projectName,
      'eventTypeId': eventTypeId,
      'inquiryDate': inquiryDate,
      'eventStartDate': eventStartDate,
      'eventStartTime': eventStartTime,
      'eventEndDate': eventEndDate,
      'eventEndTime': eventEndTime,
      'budgetAmount': budgetAmount,
      if (venueId > 0) 'venueId': venueId,
      if (priority != null) 'priority': priority,
      'eventStatus': eventStatus,
      'remarks': remarks,
      if (id > 0) 'id': id,
      if (userId > 0) 'userId': userId,
      if (partyId != null && partyId! > 0) 'partyId': partyId,
      if (eventOtherInfo != null) 'eventOtherInfo': eventOtherInfo!.toJson(),
      if (eventFunctions != null) 'eventFunctions': eventFunctions!.map((e) => e.toJson()).toList(),
    };
    return map;
  }
}

class EventOtherInfoRequestDto {
  final String? groomName;
  final String? brideName;
  final String? groomContactNumber;
  final String? brideContactNumber;

  EventOtherInfoRequestDto({
    this.groomName,
    this.brideName,
    this.groomContactNumber,
    this.brideContactNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      if (groomName != null) 'groomName': groomName,
      if (brideName != null) 'brideName': brideName,
      if (groomContactNumber != null) 'groomContactNumber': groomContactNumber,
      if (brideContactNumber != null) 'brideContactNumber': brideContactNumber,
    };
  }
}

class VenueResponseDto {
  final int id;
  final String? nameEnglish;

  VenueResponseDto({required this.id, this.nameEnglish});

  factory VenueResponseDto.fromJson(Map<String, dynamic> json) {
    return VenueResponseDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
    );
  }
}

class FunctionResponseDto {
  final int id;
  final String? nameEnglish;

  FunctionResponseDto({required this.id, this.nameEnglish});

  factory FunctionResponseDto.fromJson(Map<String, dynamic> json) {
    return FunctionResponseDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
    );
  }
}

class EventFunctionRequestDto {
  final int id;
  final int functionId;
  final String functionDate;
  final String functionTime;
  final String notesEnglish;
  final List<EventFunctionVenueRequestDto> venues;

  EventFunctionRequestDto({
    this.id = 0,
    required this.functionId,
    required this.functionDate,
    required this.functionTime,
    this.notesEnglish = '',
    required this.venues,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'functionId': functionId,
      'functionDate': functionDate,
      'functionTime': functionTime,
      'notesEnglish': notesEnglish,
      'venues': venues.map((e) => e.toJson()).toList(),
    };
  }
}

class EventFunctionVenueRequestDto {
  final int id;
  final int venueId;

  EventFunctionVenueRequestDto({this.id = 0, required this.venueId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
    };
  }
}

class EventFunctionListRequestDto {
  final int eventId;
  final List<EventFunctionRequestDto> functions;

  EventFunctionListRequestDto({required this.eventId, required this.functions});

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'functions': functions.map((e) => e.toJson()).toList(),
    };
  }
}

class PartyResponseDto {
  final int id;
  final String? nameEnglish;

  PartyResponseDto({required this.id, this.nameEnglish});

  factory PartyResponseDto.fromJson(Map<String, dynamic> json) {
    return PartyResponseDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
    );
  }
}
