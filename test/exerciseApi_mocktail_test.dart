import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:trainer_app/global/exerciseApi.dart';

import 'mocks/mock_http_service.dart';
class MockClient extends Mock implements http.Client {}
// Definimos el Fake fuera del main
class FakeUri extends Fake implements Uri {}
void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });
  late MockHttpClient mockClient;
  late ExerciseApi api;

  setUp(() {
    mockClient = MockHttpClient();
    api = ExerciseApi(client: mockClient);
  });

  // 🔹 TEST GET SUCCESS
  test('GET retorna datos correctamente', () async {
    final responseData = {"name": "Push Up"};

    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(jsonEncode(responseData), 200),
    );

    final result = await api.get('/exercises');

    expect(result['name'], 'Push Up');
    verify(() => mockClient.get(any())).called(1);
  });

  // 🔹 TEST POST SUCCESS
  test('POST envía datos correctamente', () async {
    final data = {"name": "Squat"};

    when(() => mockClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer(
      (_) async => http.Response(jsonEncode(data), 201),
    );

    final result = await api.post('/exercises', data, 'token123');

    expect(result['name'], 'Squat');
    verify(() => mockClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).called(1);
  });

  // 🔹 TEST PUT SUCCESS
  test('PUT actualiza datos correctamente', () async {
    final data = {"name": "Bench Press"};

    when(() => mockClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer(
      (_) async => http.Response(jsonEncode(data), 200),
    );

    final result = await api.put('/exercises/1', data, 'token123');

    expect(result['name'], 'Bench Press');
  });

  // 🔹 TEST ERROR
  test('Lanza excepción cuando hay error', () async {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response('Error', 500),
    );

    expect(
      () => api.get('/exercises'),
      throwsA(isA<Exception>()),
    );
  });

  // 🔹 TEST RESPUESTA VACÍA
  test('Retorna null cuando body está vacío', () async {
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response('', 200),
    );

    final result = await api.get('/exercises');

    expect(result, null);
  });
}