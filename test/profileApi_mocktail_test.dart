
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/profileApi.dart';
// Importa tu ProfileApi

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  late ProfileApi api;
  late MockClient mockClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    api = ProfileApi(client: mockClient);
  });

  group('ProfileApi Tests', () {
    const tToken = 'mi_token_seguro';

    test('getAllUsers debe retornar una lista cuando el status es 200', () async {
      // Arrange
      const responseBody = '[{"id": 1, "username": "eliza"}]';
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      // Act
      final result = await api.getAllUsers(tToken);

      // Assert
      expect(result, isA<List>());
      expect(result.first['username'], 'eliza');
      verify(() => mockClient.get(
            Uri.parse('http://192.168.15.90:8000/api/profile/'),
            headers: any(named: 'headers'),
          )).called(1);
    });

    test('getProfile debe retornar UserData cuando la respuesta es correcta', () async {
  // Arrange
  // Eliminamos la llave extra para que sea un Map puro
  final userData = {
    "success": true,
    "data": {
      "id": 1,
      "name": "eliza",
      "email": "mon4@correo.com",
      "role": "customer",
      "created_at": "2026-03-19T00:36:01.000000Z",
      "updated_at": "2026-03-19T00:36:01.000000Z",
      "profile": {
        "id": 1,
        "user_id": 1,
        "phone": "1150245521",
        "birthdate": "2026-02-26",
        "created_at": "2026-03-19T01:10:44.000000Z",
        "updated_at": "2026-03-19T01:10:44.000000Z"
      },
      "user_measurement": {
        "id": 1,
        "weight": 200,
        "height": 50,
        "gender": "female",
        "level": "advanced",
        "created_at": "2026-03-19T01:10:05.000000Z",
        "updated_at": "2026-03-19T01:10:05.000000Z",
        "user_id": 1
      }
    }
  };

  // Ahora jsonEncode recibirá un Map y funcionará perfecto
  when(() => mockClient.get(any(), headers: any(named: 'headers')))
      .thenAnswer((_) async => http.Response(jsonEncode(userData), 200));

  // Act
  final result = await api.getProfile(tToken);

  // Assert
  expect(result, isA<UserData>());
  // Ojo: En tu JSON dice "eliza", pero en tu expect pusiste "Elizabeth". 
  // Deben coincidir para que el test pase.
  expect(result.data.name, 'eliza'); 
});

    test('createProfile debe completarse sin errores con status 201', () async {
      // Arrange
      final tData = {'name': 'Nuevo Perfil'};
      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Creado', 201));

      // Act & Assert
      expect(api.createProfile(tData, tToken), completes);
    });

    test('updateProfileData debe lanzar Exception si el status no es 200', () async {
      // Arrange
      when(() => mockClient.put(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Error de servidor', 500));

      // Act & Assert
      expect(
        () => api.updateProfileData({}, tToken),
        throwsA(isA<Exception>().having((e) => e.toString(), 'mensaje', contains('500'))),
      );
    });
  });
}