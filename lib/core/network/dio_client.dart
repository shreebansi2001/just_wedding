import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../utils/logger.dart';

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
          final authService = getx.Get.find<AuthService>();
          if (authService.isAuthenticated) {
            options.headers['Authorization'] = 'Bearer ${authService.token}';
          }

          dynamic payloadData = options.data;
          if (payloadData is FormData) {
            final fields = payloadData.fields.map((f) => '${f.key}: ${f.value}').toList();
            final files = payloadData.files.map((f) => '${f.key}: [File]').toList();
            payloadData = {'fields': fields, 'files': files};
          }

          AppLogger.i(
            '🚀 REQUEST [${options.method}] => URL: ${options.uri}\n'
            'Headers: ${options.headers}\n'
            'Payload: $payloadData',
          );

          return handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.i(
            '✅ RESPONSE [${response.statusCode}] => URL: ${response.requestOptions.uri}\n'
            'Data: ${response.data}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          AppLogger.e(
            '❌ ERROR [${e.response?.statusCode}] => URL: ${e.requestOptions.uri}\n'
            'Message: ${e.message}\n'
            'Response Data: ${e.response?.data}',
          );

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
