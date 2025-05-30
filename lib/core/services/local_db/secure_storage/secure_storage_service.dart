import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService();

  get storage => _storage;

  final _storage = const FlutterSecureStorage();

  // Write value
  Future<void> write({required String key, required String value}) async =>
      await storage.write(key: key, value: value);

  // Read value
  Future<String?> read({required String key}) async =>
      await storage.read(key: key);

  // Read all
  Future<Map<String, String>> readAll() async => await storage.readAll();

  // Delete value
  Future<void> delete({required String key}) async =>
      await storage.delete(key: key);

  // Delete all
  Future<void> deleteAll() async => await storage.deleteAll();
}
