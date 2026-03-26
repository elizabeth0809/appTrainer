import 'dart:convert';
import 'package:http/http.dart' as http;
class ExerciseApi {
  final String _baseUrl = '192.168.15.90:8000';
  Map<String, String> _getHeaders(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
  Future<dynamic> get(String endpoint) async {
    final uri = Uri.http(_baseUrl, endpoint);
    final resp = await http.get(uri);
    return _processResponse(resp);
  }
  Future<dynamic> post(String endpoint, Map<String, dynamic> data, String token) async {
    final uri = Uri.http(_baseUrl, endpoint);
    final resp = await http.post(uri, headers: _getHeaders(token), body: jsonEncode(data));
    return _processResponse(resp);   
  }
  Future<dynamic> put(String endpoint, Map<String, dynamic> data, String token) async {
    final uri = Uri.http(_baseUrl, endpoint);
    final resp = await http.put(uri, headers: _getHeaders(token), body: jsonEncode(data));
    return _processResponse(resp);
  }

  dynamic _processResponse(http.Response resp) {
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp.body.isEmpty ? null : jsonDecode(resp.body);
    }
    throw Exception('Error del servidor: ${resp.statusCode}');
  }
}

