import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../routes/app_routes.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token';

  final Rx<String?> _token = Rx<String?>(null);
  final RxBool _hasSeenOnboarding = false.obs;

  String? get token => _token.value;
  bool get isAuthenticated => _token.value != null && _token.value!.isNotEmpty;
  bool get hasSeenOnboarding => _hasSeenOnboarding.value;

  Future<AuthService> init() async {
    _token.value = await _storage.read(key: _tokenKey);
    final seen = await _storage.read(key: 'has_seen_onboarding');
    _hasSeenOnboarding.value = seen == 'true';
    return this;
  }

  Future<void> setToken(String newToken) async {
    _token.value = newToken;
    await _storage.write(key: _tokenKey, value: newToken);
  }

  Future<void> clearToken() async {
    _token.value = null;
    await _storage.delete(key: _tokenKey);
  }
  
  Future<void> markOnboardingSeen() async {
    _hasSeenOnboarding.value = true;
    await _storage.write(key: 'has_seen_onboarding', value: 'true');
  }

  Future<void> logout() async {
    await clearToken();
    await _storage.deleteAll();
    Get.offAllNamed(AppRoutes.signIn);
  }
}
