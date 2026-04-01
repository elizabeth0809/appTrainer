import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/provider/secureStorageProvider.dart';
import 'package:trainer_app/global/global.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  // Obtenemos el StorageService usando el provider que ya tenías
  final storageService = ref.watch(storageServiceProvider);
  
  return HttpService(storageService: storageService);
});