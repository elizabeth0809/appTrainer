import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainer_app/global/api_config.dart';

class ObjetiveExerciseApi {
  final http.Client _client;
  final String _url = ApiConfig.baseUrl;
  ObjetiveExerciseApi({http.Client? client}) : _client = client ?? http.Client();
   Future<List<dynamic>> getAllObjetiveExercise(String token) async {
  final uri = Uri.parse('$_url/objetive');
  final response = await _client.get(uri, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  });
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    final List<dynamic> list = decodedData['data'] ?? [];
    //print(list);
    return list;
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
Future<void> createObjetive(String token, Map<String, dynamic> body) async {
  final uri = Uri.parse('$_url/objetive');

  final response = await _client.post(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode != 201 && response.statusCode != 200) {
    throw Exception('Error al crear');
  }
}
Future<void> updateObjetive(String token, int id, Map<String, dynamic> body) async {
  final uri = Uri.parse('$_url/objetive/$id');

  final response = await _client.put(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar');
  }
}
Future<void> deleteObjetive(String token, int id) async {
  final uri = Uri.parse('$_url/objetive/$id');

  final response = await _client.delete(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Error al eliminar');
  }
}
}