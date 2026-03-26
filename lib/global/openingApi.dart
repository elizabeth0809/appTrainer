import 'dart:convert';

import 'package:http/http.dart' as http;

class OpeningApi {
  final String _url = 'http://192.168.15.90:8000';
  Future<List<dynamic>> getAllOpeningApi(String token) async {
  final uri = Uri.parse('$_url/api/opening');
  final response = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  });
  
  if (response.statusCode == 200) {
    final dynamic decodedData = jsonDecode(response.body);
    if (decodedData is List) {
      return decodedData;
    } else if (decodedData is Map && decodedData.containsKey('data')) {
      return decodedData['data'];
    }
    
    return [];
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
Future<void> createOpening(String token, Map<String, dynamic> body) async {
  final uri = Uri.parse('$_url/api/opening');

  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode != 201 && response.statusCode != 200) {
    throw Exception('Error al crear: ${response.statusCode}');
  }
}
Future<void> updateOpening(String token, int id, Map<String, dynamic> body) async {
  final uri = Uri.parse('$_url/api/opening/$id');

  final response = await http.put(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar: ${response.statusCode}');
  }
}
Future<void> deleteOpening(String token, int id) async {
  final uri = Uri.parse('$_url/api/opening/$id');

  final response = await http.delete(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Error al eliminar: ${response.statusCode}');
  }
}
}