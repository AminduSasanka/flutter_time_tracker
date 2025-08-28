import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/i_secure_storage_service.dart';
import 'package:flutter_time_tracker/data/sources/local/secure_storage/secure_storage_service.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  const AndroidOptions androidOptions = AndroidOptions(
    encryptedSharedPreferences: true
  );

  const IOSOptions iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock
  );

  return const FlutterSecureStorage(
    aOptions: androidOptions,
    iOptions: iosOptions
  );
});

final secureStorageServiceProvider = Provider<ISecureStorageService>((ref) {
  return SecureStorageService(ref.watch(secureStorageProvider));
});