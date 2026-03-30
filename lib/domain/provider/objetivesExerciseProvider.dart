import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/models/model.dart'; // Ajusta a tu path real
import 'package:trainer_app/domain/provider/loginProvider.dart'; // Para el token
import 'package:trainer_app/domain/service/objetiveExerciseRepositoryService.dart';

final objetivosFutureProvider = FutureProvider<List<ObjetiveDatum>>((ref) async {
  try {
    final token = ref.watch(loginProvider.select((value) => value.user?.accessToken ?? ''));
    if (token == null || token.isEmpty) {
    throw Exception('Token vacío');
  }
    final repo = ref.watch(objetiveExerciserepositoryProvider).objetiveExerciseRepository;
    final lista = await repo.getAllObjetiveExercise(token); 
   // print("TOKEN: $token");
   // print("OBJETIVOS: $lista");
    return lista;
  } catch (e, stackTrace) {
    print("xxxxxERROR EN OBJETIVOSxxxxxxx");
    print("Mensaje: $e");
    print("Stacktrace: $stackTrace");
    rethrow;
  }
});

