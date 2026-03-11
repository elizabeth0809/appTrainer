import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/models/model.dart';

class HttpService {
  final String _baseUrl = 'http://192.168.15.90:8000';
  //auth
  Future<Map<String, dynamic>> login(String body) async {
    final url = Uri.parse('$_baseUrl/api/login/');

    try {
      final response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});
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
    final url = Uri.parse('$_baseUrl/api/register/');

    try {
      final response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});
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
  //excercises
}

