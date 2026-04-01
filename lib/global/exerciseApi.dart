import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/api_config.dart';

class ExerciseApi {
  final String baseUrl = ApiConfig.baseUrl;
  final http.Client client;

  ExerciseApi({required this.client});

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final resp = await client.get(uri);
    return _processResponse(resp);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data, String token) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final resp = await client.post(
      uri, 
      headers: _getHeaders(token), 
      body: jsonEncode(data)
    );
    return _processResponse(resp);   
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data, String token) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final resp = await client.put(
      uri, 
      headers: _getHeaders(token), 
      body: jsonEncode(data)
    );
    return _processResponse(resp);
  }

  Future<void> delete(String endpoint, String token) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final resp = await client.delete(uri, headers: _getHeaders(token));
    _processResponse(resp);
  }

  dynamic _processResponse(http.Response resp) {
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp.body.isEmpty ? null : jsonDecode(resp.body);
    }
    // Intentar extraer mensaje de error del backend si existe
    String message = 'Error del servidor: ${resp.statusCode}';
    try {
      final body = jsonDecode(resp.body);
      message = body['message'] ?? body['detail'] ?? message;
    } catch (_) {}
    
    throw Exception(message);
  }
}