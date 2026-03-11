import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/models/model.dart'; // Ajusta a tu path real
import 'package:trainer_app/domain/provider/loginProvider.dart'; // Para el token
import 'package:trainer_app/domain/service/objetiveExerciseRepositoryService.dart';

final objetivosFutureProvider = FutureProvider<List<ObjetiveDatum>>((ref) async {
  try {
    // 1. Obtenemos el token del loginProvider
    final token = ref.watch(loginProvider.select((value) => value.user?.accessToken ?? ''));
    
    // 2. Accedemos al repositorio mediante su provider
    final repo = ref.watch(objetiveExerciserepositoryProvider).objetiveExerciseRepository;

    print("--- Iniciando petición de objetivos ---");
    final lista = await repo.getAllObjetiveExercise(token);
    print("--- Objetivos cargados: ${lista.length} elementos ---");
    
    return lista;
  } catch (e, stackTrace) {
    // PRINT DETALLADO PARA DEPURACIÓN
    print("xxxxxxxxxxxxxxxx ERROR EN OBJETIVOS xxxxxxxxxxxxxxxx");
    print("Mensaje: $e");
    print("Stacktrace: $stackTrace");
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    rethrow;
  }
});

