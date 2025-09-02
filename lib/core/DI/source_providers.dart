import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_time_tracker/core/DI/repository_providers.dart';
import 'package:flutter_time_tracker/core/services/network/network_service_provider.dart';
import 'package:flutter_time_tracker/data/sources/local/database/database_service.dart';
import 'package:flutter_time_tracker/data/sources/local/database/i_database_service.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/i_secure_storage_service.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/secure_storage_service.dart';
import 'package:flutter_time_tracker/data/sources/local/shared_preferences/i_shared_preferences_service.dart';
import 'package:flutter_time_tracker/data/sources/local/shared_preferences/shared_preferences_service.dart';
import 'package:flutter_time_tracker/data/sources/remote/jira/i_jira_api_service.dart';
import 'package:flutter_time_tracker/data/sources/remote/jira/jira_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  const AndroidOptions androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  const IOSOptions iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  return const FlutterSecureStorage(
    aOptions: androidOptions,
    iOptions: iosOptions,
  );
});

final secureStorageServiceProvider = Provider<ISecureStorageService>((ref) {
  return SecureStorageService(ref.watch(secureStorageProvider));
});

final jiraApiServiceProvider = Provider<IJiraApiService>((ref) {
  return JiraApiService(
    ref.read(networkServiceProvider),
    ref.read(jiraAuthRepositoryProvider),
  );
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPreferencesServiceProvider = Provider<ISharedPreferencesService>((
  ref,
) {
  return SharedPreferencesService(ref.watch(sharedPreferencesProvider));
});

final databaseServiceProvider = Provider<IDatabaseService>((ref) {
  return DatabaseService();
});
