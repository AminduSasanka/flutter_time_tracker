import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/application/services/api_token_service.dart';
import 'package:flutter_time_tracker/core/DI/repository_providers.dart';

final apiTokenServiceProvider = Provider<ApiTokenService>((ref) {
  return ApiTokenService(ref.read(apiTokenRepositoryProvider));
});