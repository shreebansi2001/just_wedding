class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class OtpRequest {
  final String contactNo;

  OtpRequest({required this.contactNo});

  Map<String, dynamic> toJson() => {
    'contactNo': contactNo,
  };
}

class OtpVerifyRequest {
  final String contactNo;
  final String otp;

  OtpVerifyRequest({required this.contactNo, required this.otp});

  Map<String, dynamic> toJson() => {
    'contactNo': contactNo,
    'otp': otp,
  };
}

class SignupRequest {
  final String address;
  final int cityId;
  final int clientId;
  final String companyEmail;
  final String companyName;
  final String confirmPassword;
  final String contactNo;
  final String countryCode;
  final int countryId;
  final String email;
  final String firstName;
  final String lastName;
  final String officeNo;
  final String password;
  final int roleId;
  final int stateId;

  SignupRequest({
    required this.address,
    required this.cityId,
    required this.clientId,
    required this.companyEmail,
    required this.companyName,
    required this.confirmPassword,
    required this.contactNo,
    required this.countryCode,
    required this.countryId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.officeNo,
    required this.password,
    required this.roleId,
    required this.stateId,
  });

  Map<String, dynamic> toJson() => {
    'address': address,
    'cityId': cityId,
    'clientId': clientId,
    'companyEmail': companyEmail,
    'companyName': companyName,
    'confirmPassword': confirmPassword,
    'contactNo': contactNo,
    'countryCode': countryCode,
    'countryId': countryId,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'officeNo': officeNo,
    'password': password,
    'roleId': roleId,
    'stateId': stateId,
  };
}
