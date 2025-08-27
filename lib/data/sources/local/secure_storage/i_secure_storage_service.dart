abstract interface class ISecureStorageService {
  Future<String?> read(String key);

  Future<void> delete(String key);

  Future<void> write(String key, String value);
}