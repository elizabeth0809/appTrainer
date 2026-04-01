import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/objetiveExerciseApi.dart';
// Importa tu clase ObjetiveExerciseApi

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  late ObjetiveExerciseApi api;
  late MockClient mockClient;

  const tToken = 'token_abc_123';

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    api = ObjetiveExerciseApi(client: mockClient);
  });

  group('ObjetiveExerciseApi - CRUD Tests', () {
    
    test('getAllObjetiveExercise debe retornar la lista de la llave "data"', () async {
      // Arrange
      final tResponse = {
        'data': [
          {'id': 1, 'title': 'Bajar de peso'},
          {'id': 2, 'title': 'Ganar músculo'}
        ]
      };
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(tResponse), 200));

      // Act
      final result = await api.getAllObjetiveExercise(tToken);

      // Assert
      expect(result, isA<List>());
      expect(result.length, 2);
      expect(result.first['title'], 'Bajar de peso');
    });

    test('createObjetive debe completarse con éxito (201)', () async {
      // Arrange
      final tBody = {'title': 'Nuevo Objetivo'};
      when(() => mockClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Created', 201));

      // Act & Assert
      expect(api.createObjetive(tToken, tBody), completes);
      verify(() => mockClient.post(
        any(),
        headers: any(named: 'headers', that: containsPair('Authorization', 'Bearer $tToken')),
        body: jsonEncode(tBody),
      )).called(1);
    });

    test('updateObjetive debe llamar a la URL con el ID correcto', () async {
      // Arrange
      const tId = 45;
      final tBody = {'title': 'Objetivo Actualizado'};
      when(() => mockClient.put(any(), headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Updated', 200));

      // Act
      await api.updateObjetive(tToken, tId, tBody);

      // Assert
      verify(() => mockClient.put(
        Uri.parse('http://192.168.15.90:8000/api/objetive/$tId'),
        headers: any(named: 'headers'),
        body: jsonEncode(tBody),
      )).called(1);
    });

    test('deleteObjetive debe lanzar excepción si el status no es 200 ni 204', () async {
      // Arrange
      when(() => mockClient.delete(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
        () => api.deleteObjetive(tToken, 99),
        throwsA(isA<Exception>().having((e) => e.toString(), 'mensaje', contains('Error al eliminar')))
      );
    });
  });
}