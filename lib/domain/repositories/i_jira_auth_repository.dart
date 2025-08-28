abstract interface class IJiraAuthRepository {
  Future<String> getToken();

  Future<void> saveToken(String token);

  Future<void> deleteToken();
}