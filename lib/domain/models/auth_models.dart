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
  final String firstName;
  final String lastName;
  final String email;
  final String contactNo;
  final String companyName;
  final String companyEmail;
  final String officeNo;
  final String address;
  final String password;
  final String confirmPassword;
  final int cityId;
  final int stateId;
  final int countryId;
  final int clientId;
  final int roleId;
  final String countryCode;

  SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNo,
    required this.companyName,
    required this.companyEmail,
    required this.officeNo,
    required this.address,
    required this.password,
    required this.confirmPassword,
    required this.cityId,
    required this.stateId,
    required this.countryId,
    required this.clientId,
    required this.roleId,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'contactNo': contactNo,
    'companyName': companyName,
    'companyEmail': companyEmail,
    'officeNo': officeNo,
    'address': address,
    'password': password,
    'confirmPassword': confirmPassword,
    'cityId': cityId,
    'stateId': stateId,
    'countryId': countryId,
    'clientId': clientId,
    'roleId': roleId,
    'countryCode': countryCode,
  };
}
