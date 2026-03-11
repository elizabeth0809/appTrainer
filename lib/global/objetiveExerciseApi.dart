import 'dart:convert';

import 'package:http/http.dart' as http;

class ObjetiveExerciseApi {
  final String _url = 'http://192.168.15.90:8000';
   Future<List<dynamic>> getAllObjetiveExercise(String token) async {
  final uri = Uri.parse('$_url/api/objetive');
  final response = await http.get(uri, headers: {
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
}