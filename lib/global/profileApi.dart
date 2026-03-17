import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/models/model.dart';

class ProfileApi {
  final String _url = 'http://192.168.15.90:8000/api';


Future<UserData> getProfile(String token) async {
  final response = await http.get(
    Uri.parse('$_url/profile-me'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return userDataFromJson(response.body); // 👈 importante
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
 Future<void> updateProfileData(Map<String, dynamic> data, String token) async {
  final response = await http.put(
    Uri.parse('$_url/profile-user'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar perfil: ${response.body}');
  }
}
  Future<List<dynamic>> getMeasurements(String token) async {
    final response = await http.get(Uri.parse('$_url/measurement/'), headers: {'Authorization': 'Bearer $token'});
    final decoded = jsonDecode(response.body);
    return decoded is List ? decoded : decoded['data'] ?? [];
  }
  Future<void> updateMeasurementProfile(Map<String, dynamic> data, String token) async {
  final response = await http.put(
    Uri.parse('$_url/measurement-profile'), // Ruta actualizada
    headers: {
      'Authorization': 'Bearer $token', 
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(data),
  );
  
  if (response.statusCode != 200) {
    throw Exception('Error al actualizar: ${response.body}');
  }
}
}