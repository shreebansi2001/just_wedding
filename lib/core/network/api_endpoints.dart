class ApiEndpoints {
  ApiEndpoints._();

  static const String login = '/v1/api/auth/login';
  static const String requestOtp = '/v1/api/auth/login/otp/request';
  static const String verifyOtp = '/v1/api/auth/login/otp/verify';
  static const String signup = '/v1/api/auth/signup';
  
  static const String eventTypeList = '/v1/api/event-type/list';
  static const String eventAddUpdate = '/v1/api/event/add-update';
  static const String eventList = '/v1/api/event/list';
  
  static const String venueList = '/v1/api/venue/list';
  static const String functionList = '/v1/api/function/list';
  static const String eventFunctionAddUpdateList = '/v1/api/event/function/add-update-list';
  static const String partyList = '/v1/api/party-master/list';
}
