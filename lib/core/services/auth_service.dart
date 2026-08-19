import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../routes/app_routes.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'auth_user_id';

  final Rx<String?> _token = Rx<String?>(null);
  final Rx<int?> _userId = Rx<int?>(null);
  final RxBool _hasSeenOnboarding = false.obs;

  String? get token => _token.value;
  // Fallback to the same placeholder userId the rest of the app used before
  // real session wiring existed, so events created before a fresh login still work.
  int get userId => _userId.value ?? 13;
  bool get isAuthenticated => _token.value != null && _token.value!.isNotEmpty;
  bool get hasSeenOnboarding => _hasSeenOnboarding.value;

  Future<AuthService> init() async {
    _token.value = await _storage.read(key: _tokenKey);
    final storedUserId = await _storage.read(key: _userIdKey);
    _userId.value = storedUserId != null ? int.tryParse(storedUserId) : null;
    final seen = await _storage.read(key: 'has_seen_onboarding');
    _hasSeenOnboarding.value = seen == 'true';
    return this;
  }

  Future<void> setToken(String newToken) async {
    _token.value = newToken;
    await _storage.write(key: _tokenKey, value: newToken);
  }

  Future<void> setUserId(int id) async {
    _userId.value = id;
    await _storage.write(key: _userIdKey, value: id.toString());
  }

  Future<void> clearToken() async {
    _token.value = null;
    _userId.value = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userIdKey);
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
