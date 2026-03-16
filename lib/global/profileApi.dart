import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileApi {
  final String _url = 'http://192.168.15.90:8000/api';


Future<dynamic> getProfile(String token) async {
  final response = await http.get(
    Uri.parse('$_url/profile/'), 
    headers: {'Authorization': 'Bearer $token'}
  );
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}
 Future<void> updateProfile(int id, Map<String, dynamic> data, String token) async {
    await http.put(
      Uri.parse('$_url/profile/$id/'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }
  Future<List<dynamic>> getMeasurements(String token) async {
    final response = await http.get(Uri.parse('$_url/measurement/'), headers: {'Authorization': 'Bearer $token'});
    final decoded = jsonDecode(response.body);
    return decoded is List ? decoded : decoded['data'] ?? [];
  }
  Future<void> updateMeasurement(int id, Map<String, dynamic> data, String token) async {
  final response = await http.put(
    Uri.parse('$_url/measurement/$id/'),
    headers: {
      'Authorization': 'Bearer $token', 
      'Content-Type': 'application/json'
    },
    body: jsonEncode(data),
  );
  
  if (response.statusCode != 200) {
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
}