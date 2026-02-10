import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/models/model.dart';

class HttpService {
  final String _baseUrl = 'http://192.168.15.90:8000';

  Future<List<Exercise>> getExercises() async {
    final url = Uri.parse('$_baseUrl/api/exercise');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // 🔥 CONVERSIÓN CORRECTA
        return exerciseFromJson(response.body);
      } else {
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        throw Exception('Error del servidor');
      }
    } catch (e) {
      print('Error de conexión: $e');
      throw Exception('No se pudo conectar al servidor');
    }
  }
}

