import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/loginApi.dart';
// Importa tu archivo de HttpService

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  late HttpService service;
  late MockClient mockClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    service = HttpService(client: mockClient);
  });

  group('HttpService - Auth Tests', () {
    
    test('login debe retornar un Map con el token cuando el login es exitoso', () async {
      // 1. Arrange: Preparamos los datos
      const loginBody = '{"email": "mon4@correo.com", "password": "12345678"}';
      const mockResponse = '{"token": "abc-123", "user": "Eliza"}';

      when(() => mockClient.post(
        any(), 
        body: any(named: 'body'), 
        headers: any(named: 'headers')
      )).thenAnswer((_) async => http.Response(mockResponse, 200));

      // 2. Act: Ejecutamos el método
      final result = await service.login(loginBody);

      // 3. Assert: Verificamos resultados y comportamiento
      expect(result['token'], 'abc-123');
      expect(result['user'], 'Eliza');
      
      // Verificamos que se llamó a la URL correcta
      verify(() => mockClient.post(
        Uri.parse('http://192.168.15.90:8000/api/login/'),
        body: loginBody,
        headers: {'Content-Type': 'application/json'}
      )).called(1);
    });

    test('register debe lanzar una Exception con el mensaje del servidor si falla', () async {
      // 1. Arrange
      const regBody = '{"email": "error@test.com"}';
      const errorJson = '{"message": "El correo ya existe"}';

      when(() => mockClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(errorJson, 400));

      // 2. Act & Assert
      // Verificamos que lance una Exception y que el mensaje contenga el texto esperado
      expect(
        () => service.register(regBody), 
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('El correo ya existe')))
      );
    });
  });
}