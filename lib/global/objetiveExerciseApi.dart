import 'dart:convert';

import 'package:http/http.dart' as http;

class ObjetiveExerciseApi {
  final String _url = 'http://192.168.15.90:8000';
   Future<List<dynamic>> getAllObjetiveExercise(String token) async {
  final uri = Uri.parse('$_url/api/objetive');
  final response = await http.get(uri, headers: {
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
  final uri = Uri.parse('$_url/api/objetive');

  final response = await http.post(
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
  final uri = Uri.parse('$_url/api/objetive/$id');

  final response = await http.put(
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
  final uri = Uri.parse('$_url/api/objetive/$id');

  final response = await http.delete(
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