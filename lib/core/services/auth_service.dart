import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';

  final Rx<String?> _token = Rx<String?>(null);
  final Rx<int?> _userId = Rx<int?>(null);
  final RxBool _hasSeenOnboarding = false.obs;

  String? get token => _token.value;
  int get userId => _userId.value ?? 0;
  bool get isAuthenticated => _token.value != null && _token.value!.isNotEmpty;
  bool get hasSeenOnboarding => _hasSeenOnboarding.value;

  Future<AuthService> init() async {
    _token.value = await _storage.read(key: _tokenKey);
    final storedUserId = await _storage.read(key: _userIdKey);
    if (storedUserId != null) {
      _userId.value = int.tryParse(storedUserId);
    }
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

  Future<void> clearAuth() async {
    _token.value = null;
    _userId.value = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userIdKey);
  }
  
  // Backward compatibility wrapper
  Future<void> clearToken() async => clearAuth();
  
  Future<void> markOnboardingSeen() async {
    _hasSeenOnboarding.value = true;
    await _storage.write(key: 'has_seen_onboarding', value: 'true');
  }
}
