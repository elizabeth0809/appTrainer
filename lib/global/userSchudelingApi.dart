import 'dart:convert';

import 'package:http/http.dart' as http;

class UserSchudelingApi {
  final String _url = 'http://192.168.15.90:8000';

 Future<List<dynamic>> getAll(String access_token) async {
  final uri = Uri.parse('$_url/api/scheduling/');
  final headers = {
    'Authorization': 'Bearer $access_token',
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(uri, headers: headers);
    
    if (response.statusCode == 200) {
      // 1. Decodificamos el mapa completo
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      // 2. Retornamos solo la lista que está en la llave "data"
      return decodedData['data'] as List<dynamic>; 
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  } catch (err) {
    throw Exception('Error de conexión: $err');
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