import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/api_config.dart';

class HttpService {
  final http.Client _client;
  final String _baseUrl = ApiConfig.baseUrl;
  //constructor
  HttpService({http.Client? client}) : _client = client ?? http.Client();
  //auth
  Future<Map<String, dynamic>> login(String body) async {
    final url = Uri.parse('$_baseUrl/login/');

    try {
      final response = await _client.post(url, body: body, headers: {'Content-Type': 'application/json'});
      final statusCode = response.statusCode;
      if (statusCode == HttpStatus.ok) {
        return jsonDecode(response.body);
      }
      throw Exception('$statusCode: ${response.reasonPhrase}');
    } catch (err) {
      throw Exception('$err');
    }
  }
  //register
  Future<Map<String, dynamic>> register(String body) async {
    final url = Uri.parse('$_baseUrl/register/');

    try {
      final response = await _client.post(url, body: body, headers: {'Content-Type': 'application/json'});
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body);
    }
    final errorBody = jsonDecode(response.body);
    throw Exception(errorBody['message'] ?? '$statusCode Error');
    } catch (err) {
      throw Exception('$err');
    }
  }
}

