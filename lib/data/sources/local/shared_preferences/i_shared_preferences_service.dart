abstract interface class ISharedPreferencesService {
  String? readJsonString(String key);

  void deleteJsonString(String key);

  void writeJsonString(String key, String value);
}