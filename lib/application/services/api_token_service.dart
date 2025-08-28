import 'package:flutter_time_tracker/domain/repositories/i_api_token_repository.dart';

class ApiTokenService {
  final IApiTokenRepository _apiTokenRepository;

  ApiTokenService(this._apiTokenRepository);

  Future<void> saveApiToken(String token) async {
    try {
      await _apiTokenRepository.saveToken(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteApiToken() async {
    try {
      await _apiTokenRepository.deleteToken();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getApiToken() async {
    try {
      return await _apiTokenRepository.getToken();
    } catch (e) {
      rethrow;
    }
  }
}
