import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/core/DI/source_providers.dart';
import 'package:flutter_time_tracker/data/repositories/api_token_repository.dart';
import 'package:flutter_time_tracker/domain/repositories/i_api_token_repository.dart';

final apiTokenRepositoryProvider = Provider<IApiTokenRepository>((ref) {
  return ApiTokenRepository(ref.watch(secureStorageServiceProvider));
});