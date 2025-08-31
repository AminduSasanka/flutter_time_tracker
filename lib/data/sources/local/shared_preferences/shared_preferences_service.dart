import 'package:flutter_time_tracker/data/sources/local/shared_preferences/i_shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ISharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  @override
  void deleteJsonString(String key) async {
    try {
      _sharedPreferences.remove(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  String? readJsonString(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void writeJsonString(String key, String value) {
    try {
      _sharedPreferences.setString(key, value);
    } catch (e) {
      rethrow;
    }
  }
}