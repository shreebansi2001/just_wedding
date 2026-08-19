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
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
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
          Logger.success(
            '<-- ${response.statusCode} ${response.requestOptions.uri}',
          );
          if (response.requestOptions.path.contains('/event/add-update')) {
            Logger.success('Response: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          Logger.error(
            '<-- Error ${e.response?.statusCode} ${e.requestOptions.uri}',
          );
          Logger.error(e.message ?? 'Unknown error');
          if (e.response?.data != null) {
            Logger.error('Response: ${e.response!.data}');
          }

          final isAuthEndpoint = e.requestOptions.path.contains(
            '/v1/api/auth/',
          );

          if (e.response?.statusCode == 401 && !isAuthEndpoint) {
            final authService = getx.Get.find<AuthService>();
            authService.clearToken();
            if (getx.Get.currentRoute != AppRoutes.signIn) {
              getx.Get.offAllNamed(AppRoutes.signIn);
            }
          }

          String parsedErrorMessage =
              e.message ?? 'An unexpected error occurred';
          if (e.response?.data != null &&
              e.response!.data is Map<String, dynamic>) {
            final responseData = e.response!.data as Map<String, dynamic>;
            parsedErrorMessage =
                _extractErrorMessage(responseData) ?? parsedErrorMessage;
          }

          final customException = e.copyWith(error: parsedErrorMessage);

          return handler.next(customException);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

/// Mirrors the web app's extractErrorMessage (swalHelpers.js): the backend's
/// errorMessage/message/error fields can be a plain string, a list of
/// strings, or a validation field-map ({ field: "msg" } or { field: [msgs] }),
/// so a naive `responseData['errorMessage'] ?? ...` crashes whenever it's not a String.
String? _extractErrorMessage(Map<String, dynamic> responseData) {
  for (final key in ['errorMessage', 'message', 'error']) {
    final value = responseData[key];
    if (value is String && value.trim().isNotEmpty) return value;
    if (value is List && value.isNotEmpty) {
      final lines = value.whereType<String>().toList();
      if (lines.isNotEmpty) return lines.join('\n');
    }
    if (value is Map) {
      final lines = value.values
          .expand((v) => v is List ? v : [v])
          .whereType<String>()
          .toList();
      if (lines.isNotEmpty) return lines.join('\n');
    }
  }

  final errors = responseData['errors'];
  if (errors is List && errors.isNotEmpty) {
    final lines = errors
        .map((e) => e is String ? e : (e is Map ? e['message'] : null))
        .whereType<String>()
        .toList();
    if (lines.isNotEmpty) return lines.join('\n');
  }

  return null;
}
