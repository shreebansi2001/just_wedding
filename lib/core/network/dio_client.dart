import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../utils/logger.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://hoteltiptopplaza.in/JWPortal', // Live URL
        // baseUrl: 'http://192.168.0.47:5102', // Local development URL
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Logger.info('--> ${options.method} ${options.uri}');
          if (options.data != null) Logger.info('Data: ${options.data}');
          
          final authService = getx.Get.find<AuthService>();
          if (authService.isAuthenticated) {
            options.headers['Authorization'] = 'Bearer ${authService.token}';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          Logger.success('<-- ${response.statusCode} ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          Logger.error('<-- Error ${e.response?.statusCode} ${e.requestOptions.uri}');
          Logger.error(e.message ?? 'Unknown error');
          
          final isAuthEndpoint = e.requestOptions.path.contains('/v1/api/auth/');
          
          if (e.response?.statusCode == 401 && !isAuthEndpoint) {
            final authService = getx.Get.find<AuthService>();
            authService.clearToken();
            if (getx.Get.currentRoute != AppRoutes.signIn) {
              getx.Get.offAllNamed(AppRoutes.signIn);
            }
          }
          
          String parsedErrorMessage = e.message ?? 'An unexpected error occurred';
          if (e.response?.data != null && e.response!.data is Map<String, dynamic>) {
            final responseData = e.response!.data as Map<String, dynamic>;
            parsedErrorMessage = responseData['errorMessage'] ?? responseData['message'] ?? responseData['error'] ?? parsedErrorMessage;
          }

          final customException = e.copyWith(
            error: parsedErrorMessage,
          );

          return handler.next(customException);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
