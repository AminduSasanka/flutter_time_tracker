abstract interface class IApiTokenRepository {
  Future<String> getToken();

  Future<void> saveToken(String token);

  Future<void> deleteToken();
}