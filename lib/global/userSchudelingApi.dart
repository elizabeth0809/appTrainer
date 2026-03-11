import 'dart:convert';

import 'package:http/http.dart' as http;

class UserSchudelingApi {
  final String _url = 'http://192.168.15.90:8000';

Future<Map<String, dynamic>> create(Map<String, dynamic> data, String token) async {
  final uri = Uri.parse('$_url/api/scheduling/');
  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error al crear scheduling: ${response.statusCode}');
  }
}
 Future<List<dynamic>> getAll(String token) async {
  final uri = Uri.parse('$_url/api/scheduling');
  final response = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  });
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    final List<dynamic> list = decodedData['data'] ?? [];
    return list;
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
Future<void> delete(int id, String token) async {
  final uri = Uri.parse('$_url/api/scheduling/$id/');
  final response = await http.delete(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode != 204 && response.statusCode != 200) {
    throw Exception('No se pudo eliminar el recurso');
  }
}
}