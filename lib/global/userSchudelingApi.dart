import 'dart:convert';

import 'package:http/http.dart' as http;

class UserSchudelingApi {
  final String _url = 'http://192.168.15.90:8000';

  // Cambio: Ahora retorna una Lista de mapas, no un Mapa único
  Future<List<dynamic>> getAll(String access_token) async {
    final uri = Uri.parse('$_url/api/scheduling/');
    final headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json', // Es buena práctica agregarlo
    };

    try {
      final response = await http.get(uri, headers: headers);
      
      if (response.statusCode == 200) {
        // jsonDecode aquí devolverá una List<dynamic> según tu JSON de ejemplo
        return jsonDecode(response.body);
      } else {
        throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (err) {
      // Evita anidar Exceptions; lanza el error directamente o uno personalizado
      throw Exception('Error de conexión: $err');
    }
  }
}