import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class SecureStorageRepository {
  Future<String?> readString(String key);
  Future<void> writeString(String key, String value);
  Future<void> deleteString(String key);
  Future<void> containsKey(String key);
}

final secureStorageRepositoryProvider =
    Provider<SecureStorageRepository>((ref) {
  return SecureStorageRepositoryImpl();
});

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final _secureStorage = const FlutterSecureStorage();

  IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() => const AndroidOptions();

  @override
  Future<String?> readString(String key) async {
    return await _secureStorage.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<void> writeString(String key, String value) async {
    await _secureStorage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<void> deleteString(String key) async {
    await _secureStorage.delete(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }
}
