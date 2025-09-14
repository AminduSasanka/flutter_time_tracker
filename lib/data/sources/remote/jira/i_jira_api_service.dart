abstract interface class IJiraApiService {
  Future<Map<String, dynamic>> get(
    String url,
    Map<String, dynamic>? queryParams,
  );

  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> body);

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);

  Future<dynamic> delete(String url);
}
