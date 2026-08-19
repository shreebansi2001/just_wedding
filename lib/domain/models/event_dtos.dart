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

  // Mirrors the web app's buildEventPayload.js: every key is always present
  // (null/empty defaults instead of omission) because the backend appears to
  // dereference nested objects like eventOtherInfo/eventFunctions unconditionally.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id > 0 ? id : null,
      'userId': userId > 0 ? userId : null,
      'title': title ?? 'MR',
      'projectName': projectName,
      'eventTypeId': eventTypeId,
      'priority': priority ?? 'HIGH',
      'venueId': venueId > 0 ? venueId : null,
      'inquiryDate': inquiryDate,
      'eventStatus': eventStatus,
      'eventStartDate': eventStartDate,
      'eventStartTime': eventStartTime,
      'eventEndDate': eventEndDate,
      'eventEndTime': eventEndTime,
      'budgetAmount': budgetAmount,
      'remarks': remarks,
      'partyId': partyId != null && partyId! > 0 ? partyId : null,
      'eventFunctions': (eventFunctions ?? const <EventFunctionRequestDto>[])
          .map((e) => e.toJson())
          .toList(),
      'eventOtherInfo': (eventOtherInfo ?? EventOtherInfoRequestDto()).toJson(),
    };
  }
}

class EventOtherInfoRequestDto {
  final int? id;
  final String? groomName;
  final String? groomFatherName;
  final String? groomContactNumber;
  final String? groomInstaId;
  final String? groomBirthdate;
  final String? groomPhotographerName;
  final String? groomPhotographerContactNumber;
  final String? brideName;
  final String? brideFatherName;
  final String? brideContactNumber;
  final String? brideInstaId;
  final String? brideBirthdate;
  final String? bridePhotographerName;
  final String? bridePhotographerContactNumber;
  final String? photographerDetailType; // GROOM_BRIDE, OTHER_REFERENCE

  EventOtherInfoRequestDto({
    this.id,
    this.groomName,
    this.groomFatherName,
    this.groomContactNumber,
    this.groomInstaId,
    this.groomBirthdate,
    this.groomPhotographerName,
    this.groomPhotographerContactNumber,
    this.brideName,
    this.brideFatherName,
    this.brideContactNumber,
    this.brideInstaId,
    this.brideBirthdate,
    this.bridePhotographerName,
    this.bridePhotographerContactNumber,
    this.photographerDetailType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id != null && id! > 0 ? id : null,
      'photographerDetailType': photographerDetailType ?? 'GROOM_BRIDE',
      'groomName': groomName ?? '',
      'groomFatherName': groomFatherName ?? '',
      'groomContactNumber': groomContactNumber ?? '',
      'groomInstaId': groomInstaId ?? '',
      'groomBirthdate': groomBirthdate ?? '',
      'groomPhotographerName': groomPhotographerName ?? '',
      'groomPhotographerContactNumber': groomPhotographerContactNumber ?? '',
      'brideName': brideName ?? '',
      'brideFatherName': brideFatherName ?? '',
      'brideContactNumber': brideContactNumber ?? '',
      'brideInstaId': brideInstaId ?? '',
      'brideBirthdate': brideBirthdate ?? '',
      'bridePhotographerName': bridePhotographerName ?? '',
      'bridePhotographerContactNumber': bridePhotographerContactNumber ?? '',
    };
  }
}

class SubVenueResponseDto {
  final int id;
  final String? nameEnglish;

  SubVenueResponseDto({required this.id, this.nameEnglish});

  factory SubVenueResponseDto.fromJson(Map<String, dynamic> json) {
    return SubVenueResponseDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
    );
  }
}

class VenueResponseDto {
  final int id;
  final String? nameEnglish;
  final List<SubVenueResponseDto> subVenues;

  VenueResponseDto({
    required this.id,
    this.nameEnglish,
    this.subVenues = const [],
  });

  factory VenueResponseDto.fromJson(Map<String, dynamic> json) {
    final subVenuesJson = json['subVenues'] as List?;
    return VenueResponseDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
      subVenues:
          subVenuesJson
              ?.whereType<Map<String, dynamic>>()
              .map(SubVenueResponseDto.fromJson)
              .toList() ??
          const [],
    );
  }
}

class FunctionResponseDto {
  final int id;
  final String? nameEnglish;
  final String? timeFrom;

  FunctionResponseDto({required this.id, this.nameEnglish, this.timeFrom});

  factory FunctionResponseDto.fromJson(Map<String, dynamic> json) {
    return FunctionResponseDto(
      id: json['id'] ?? 0,
      nameEnglish: json['nameEnglish'],
      timeFrom: json['timeFrom'],
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
  final List<int> subVenueId;

  EventFunctionVenueRequestDto({
    this.id = 0,
    required this.venueId,
    this.subVenueId = const [],
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'venueId': venueId, 'subVenueId': subVenueId};
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
