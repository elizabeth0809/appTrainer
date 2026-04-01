import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/openingApi.dart';
// Importa tu archivo de OpeningApi

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  late OpeningApi api;
  late MockClient mockClient;

  const tToken = 'token_opening_123';
  const tBaseUrl = 'http://192.168.15.90:8000/api/opening';

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    api = OpeningApi(client: mockClient);
  });

  group('OpeningApi - Tests Detallados', () {
    
    test('getAllOpeningApi debe manejar una respuesta que es directamente una Lista', () async {
  // Arrange
  final tListResponse = [
    {"id": 1, "name": "horario lunes", "day": "mon", "start_time": "07:30:00"},
    {"id": 2, "name": "horario", "day": "mon", "start_time": "07:30:00"}
  ];
  
  when(() => mockClient.get(any(), headers: any(named: 'headers')))
      .thenAnswer((_) async => http.Response(jsonEncode(tListResponse), 200));

  // Act
  final result = await api.getAllOpeningApi(tToken);

  // Assert
  expect(result, isA<List>());
  expect(result.length, 2); // Verificamos que hay exactamente 2 elementos

  // Objeto 0
  expect(result[0]['id'], 1);
  expect(result[0]['name'], 'horario lunes');

  // Objeto 1
  expect(result[1]['id'], 2);
  expect(result[1]['name'], 'horario');    
});

    test('getAllOpeningApi debe manejar una respuesta tipo Map con llave "data"', () async {
      // Arrange: Simulamos que el backend devuelve {"data": [{}, {}]}
      final tMapResponse = {
        'data': [
          {'id': 3, 'name': 'Apertura Noche'}
        ]
      };
      
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(tMapResponse), 200));

      // Act
      final result = await api.getAllOpeningApi(tToken);

      // Assert
      expect(result.length, 1);
      expect(result[0]['name'], 'Apertura Noche');
    });

    test('createOpening debe enviar el body correctamente codificado', () async {
      // Arrange
      final tBody = {'name': 'Nueva Apertura', 'hours': 8};
      when(() => mockClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Creado', 201));

      // Act
      await api.createOpening(tToken, tBody);

      // Assert
      verify(() => mockClient.post(
        Uri.parse(tBaseUrl),
        headers: any(named: 'headers', that: containsPair('Authorization', 'Bearer $tToken')),
        body: jsonEncode(tBody),
      )).called(1);
    });

    test('updateOpening debe concatenar el ID en la URL y manejar error 400', () async {
      // Arrange
      const tId = 10;
      when(() => mockClient.put(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      // Act & Assert
      expect(
        () => api.updateOpening(tToken, tId, {}),
        throwsA(isA<Exception>().having((e) => e.toString(), 'mensaje', contains('400')))
      );
      
      verify(() => mockClient.put(
        Uri.parse('$tBaseUrl/$tId'),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).called(1);
    });

    test('deleteOpening debe completarse con éxito en status 204 (No Content)', () async {
      // Arrange
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 204));

      // Act & Assert
      expect(api.deleteOpening(tToken, 5), completes);
    });
  });
}