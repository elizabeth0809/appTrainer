import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/provider/provider.dart';
import 'package:trainer_app/global/api_config.dart';

class HttpService {
  final http.Client _client;
  final StorageService? _storageService;
  final String _baseUrl = ApiConfig.baseUrl;
  //constructor
  HttpService({
    http.Client? client, 
    StorageService? storageService
  }) : _client = client ?? http.Client(),
       _storageService = storageService;
  //auth
  Future<Map<String, dynamic>> login(String body) async {
    final url = Uri.parse('$_baseUrl/login/');

    try {
      final response = await _client.post(
        url, 
        body: body, 
        headers: {'Content-Type': 'application/json'}
      );
      
      final statusCode = response.statusCode;
      
      if (statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // --- AQUÍ APLICAMOS LA SEGURIDAD ---
        // Asumiendo que tu API devuelve el token en un campo llamado 'token' o 'access_token'
        final token = data['token'] ?? data['access_token'];
        if (token != null) {
          await _storageService?.saveToken(token);
        }
        
        return data;
      }
      throw Exception('$statusCode: ${response.reasonPhrase}');
    } catch (err) {
      throw Exception('Error en Login: $err');
    }
  }
  //register
  Future<Map<String, dynamic>> register(String body) async {
    final url = Uri.parse('$_baseUrl/register/');

    try {
      final response = await _client.post(
        url, 
        body: body, 
        headers: {'Content-Type': 'application/json'}
      );
      
      final statusCode = response.statusCode;
      final data = jsonDecode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        // También guardamos el token al registrarse si la API lo devuelve
        final token = data['token'] ?? data['access_token'];
        if (token != null) {
          await _storageService?.saveToken(token);
        }
        return data;
      }
      
      throw Exception(data['message'] ?? '$statusCode Error');
    } catch (err) {
      throw Exception('Error en Registro: $err');
    }
  }

}

