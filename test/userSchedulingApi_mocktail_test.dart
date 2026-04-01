import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/userSchudelingApi.dart';
// Importa tu archivo de UserSchudelingApi

// Creamos el Mock del cliente
class MockClient extends Mock implements http.Client {}

// Creamos el Fake para Uri (obligatorio para Mocktail + Null Safety)
class FakeUri extends Fake implements Uri {}

void main() {
  late UserSchudelingApi api;
  late MockClient mockClient;

  const String tToken = 'test_token_123';

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    api = UserSchudelingApi(client: mockClient);
  });

  group('UserSchudelingApi - Tests de Programación', () {
    test(
      'create debe retornar un Map cuando la respuesta es exitosa (201)',
      () async {
        // Arrange
        final tData = {'exercise_id': 1, 'date': '2026-04-01'};
        final tResponse = {'id': 10, 'status': 'created'};

        when(
          () => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(tResponse), 201));

        // Act
        final result = await api.create(tData, tToken);

        // Assert
        expect(result['id'], 10);
        verify(
          () => mockClient.post(
            Uri.parse('http://192.168.15.90:8000/api/scheduling/'),
            headers: {
              'Authorization': 'Bearer $tToken',
              'Content-Type':
                  'application/json', // Asegúrate de incluir todos los que enviás en el código
            },
            body: jsonEncode(tData),
          ),
        ).called(1);
      },
    );

    test(
      'getMyScheduliung debe retornar una lista extraída de la llave "data"',
      () async {
        // Arrange
        final tRawResponse = {
          'success': true,
          'data': [
            {'id': 1, 'name': 'Entrenamiento A'},
            {'id': 2, 'name': 'Entrenamiento B'},
          ],
        };

        when(
          () => mockClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response(jsonEncode(tRawResponse), 200));

        // Act
        final result = await api.getMyScheduliung(tToken);

        // Assert
        expect(result, isA<List>());
        expect(result.length, 2);
        expect(result[0]['name'], 'Entrenamiento A');
      },
    );

    test('delete debe completarse con éxito cuando el status es 204', () async {
      // Arrange
      when(
        () => mockClient.delete(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act & Assert
      expect(api.delete(1, tToken), completes);
    });

    test(
      'create debe lanzar una Exception si el servidor devuelve un error 400',
      () async {
        // Arrange
        when(
          () => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 400));

        // Act & Assert
        expect(
          () => api.create({}, tToken),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'mensaje',
              contains('400'),
            ),
          ),
        );
      },
    );
  });
}
