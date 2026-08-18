import '../models/auth_models.dart';

abstract class AuthRepository {
  Future<dynamic> login(LoginRequest request);
  Future<dynamic> requestOtp(OtpRequest request);
  Future<dynamic> verifyOtp(OtpVerifyRequest request);
  Future<dynamic> signup(SignupRequest request);
}
