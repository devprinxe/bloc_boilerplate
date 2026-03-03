import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppLocalStorage {
  final SharedPreferences _prefs;

  AppLocalStorage(this._prefs);

  // --- Keys ---
  static const String _keyToken = 'auth_token';
  static const String _keyIsFirstTime = 'is_first_time';

  // --- Methods ---

  /// Save the Auth JWT Token
  Future<bool> saveToken(String token) async {
    return await _prefs.setString(_keyToken, token);
  }

  /// Retrieve the Auth JWT Token
  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  /// Remove token (Logout)
  Future<bool> clearToken() async {
    return await _prefs.remove(_keyToken);
  }

  /// Check if it's the user's first time
  bool isFirstTime() {
    return _prefs.getBool(_keyIsFirstTime) ?? true;
  }

  /// Set first time flag to false
  Future<bool> setFirstTimeComplete() async {
    return await _prefs.setBool(_keyIsFirstTime, false);
  }

  /// Generic Clear for all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
