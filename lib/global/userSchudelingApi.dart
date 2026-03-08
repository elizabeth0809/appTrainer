import 'dart:convert';

import 'package:http/http.dart' as http;

class UserSchudelingApi {
  final String _url = 'http://192.168.15.90:8000';

 Future<List<dynamic>> getAll(String access_token) async {
  final uri = Uri.parse('$_url/api/scheduling');
  final response = await http.get(uri, headers: {
    'Authorization': 'Bearer $access_token',
    'Content-Type': 'application/json',
  });
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    
    // AQUÍ ESTÁ LA SEGURIDAD: 
    // Si 'data' es nulo, devolvemos una lista vacía en lugar de null
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