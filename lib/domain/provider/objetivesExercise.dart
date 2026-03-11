import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trainer_app/domain/models/model.dart';

final objetivosListProvider = FutureProvider<List<ObjetiveExercise>>((ref) async {
  // Cambia 127.0.0.1 por 10.0.2.2 si usas emulador Android
  final response = await http.get(Uri.parse('192.168.15.90:8000/api/objetive'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    final List<dynamic> data = decodedData['data'];
    return data.map((item) => ObjetiveExercise.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar objetivos');
  }
});