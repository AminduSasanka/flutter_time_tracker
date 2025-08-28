import 'package:flutter_time_tracker/core/constants/secure_storage_keys.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/i_secure_storage_service.dart';
import 'package:flutter_time_tracker/domain/repositories/i_api_token_repository.dart';

class ApiTokenRepository implements IApiTokenRepository {
  final ISecureStorageService _secureStorageService;

  ApiTokenRepository(this._secureStorageService);

  @override
  Future<void> deleteToken() async {
    try {
      await _secureStorageService.delete(SecureStorageKeys.apiTokenKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      String? token = await _secureStorageService.read(
        SecureStorageKeys.apiTokenKey,
      );

      if (token != null) {
        return token;
      } else {
        throw Exception('Token not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await _secureStorageService.write(SecureStorageKeys.apiTokenKey, token);
    } catch (e) {
      rethrow;
    }
  }
}
