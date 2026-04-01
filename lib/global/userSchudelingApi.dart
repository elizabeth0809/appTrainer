import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trainer_app/global/api_config.dart';

class UserSchudelingApi {
  final http.Client _client;
  final String _url = ApiConfig.baseUrl;
UserSchudelingApi({http.Client? client}) : _client = client ?? http.Client();
//create
Future<Map<String, dynamic>> create(Map<String, dynamic> data, String token) async {
  final uri = Uri.parse('$_url/scheduling/');
  final response = await _client.post(
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
//all
 Future<List<dynamic>> getAll(String token) async {
  final uri = Uri.parse('$_url/scheduling');
  final response = await _client.get(uri, headers: {
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
//me
Future<List<dynamic>> getMyScheduliung(String token) async {
  final uri = Uri.parse('$_url/my-scheduling');
  final response = await _client.get(uri, headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  });
  /*print("STATUS: ${response.statusCode}");
  print("BODY: ${response.body}");*/
  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    final List<dynamic> list = decodedData['data'] ?? [];
    return list;
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
//delete
Future<void> delete(int id, String token) async {
  final uri = Uri.parse('$_url/scheduling/$id/');
  final response = await _client.delete(
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