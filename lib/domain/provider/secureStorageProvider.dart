import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Provider básico para la instancia de storage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Clase para manejar operaciones comunes
class StorageService {
  final FlutterSecureStorage _storage;
  StorageService(this._storage);

  Future<void> saveToken(String token) async => await _storage.write(key: 'auth_token', value: token);
  Future<String?> getToken() async => await _storage.read(key: 'auth_token');
  Future<void> deleteToken() async => await _storage.delete(key: 'auth_token');
}

final storageServiceProvider = Provider<StorageService>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return StorageService(storage);
});