import '../../core/network/dio_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../domain/models/auth_models.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient _dioClient;

  AuthRepositoryImpl(this._dioClient);

  @override
  Future<dynamic> login(LoginRequest request) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return response.data;
  }

  @override
  Future<dynamic> requestOtp(OtpRequest request) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.requestOtp,
      data: request.toJson(),
    );
    return response.data;
  }

  @override
  Future<dynamic> verifyOtp(OtpVerifyRequest request) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
    );
    return response.data;
  }

  @override
  Future<dynamic> signup(SignupRequest request) async {
    final response = await _dioClient.dio.post(
      ApiEndpoints.signup,
      data: request.toJson(),
    );
    return response.data;
  }
}
