import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainer_app/global/api_config.dart';

class OpeningApi {
  final http.Client _client;
  final String _url = ApiConfig.baseUrl;
  OpeningApi({http.Client? client}) : _client = client ?? http.Client();
  Future<List<dynamic>> getAllOpeningApi(String token) async {
  final uri = Uri.parse('$_url/opening');
  final response = await _client.get(uri, headers: {
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
  final uri = Uri.parse('$_url/opening');

  final response = await _client.post(
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
  final uri = Uri.parse('$_url/opening/$id');

  final response = await _client.put(
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

  final response = await _client.delete(
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