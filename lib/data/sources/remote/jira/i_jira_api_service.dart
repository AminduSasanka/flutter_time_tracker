abstract interface class IJiraApiService {
  Future<Map<String, dynamic>> get(
    String url,
    Map<String, dynamic>? queryParams,
  );

  Future<Map<String, dynamic>> put();

  Future<Map<String, dynamic>> post();

  Future<Map<String, dynamic>> delete();
}
