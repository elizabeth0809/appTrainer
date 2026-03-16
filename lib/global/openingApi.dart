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
    
    // Verificamos si es una lista o un mapa con llave 'data'
    if (decodedData is List) {
      return decodedData; // Es la lista directa [...]
    } else if (decodedData is Map && decodedData.containsKey('data')) {
      return decodedData['data']; // Es un objeto { "data": [...] }
    }
    
    return [];
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
}