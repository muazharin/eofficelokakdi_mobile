import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // Save data
  Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read data
  Future<String?> getData(String key) async {
    return await _storage.read(key: key);
  }

  // Delete data
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all storage
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
