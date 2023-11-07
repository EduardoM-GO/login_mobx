import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/app/modulos/informacao/cache/informacao_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late List<String> informacoes;
  late SharedPreferences preferences;
  late InformacaoCache cache;

  setUp(() {
    informacoes = List.generate(10, (index) => '$index');
    preferences = _MockSharedPreferences();
    cache = InformacaoCacheImpl(preferences);
  });

  group('informacao cache - get -', () {
    test('Ok', () {
      when(
        () => preferences.getStringList('informacoes'),
      ).thenReturn(informacoes);

      final result = cache.get();

      expect(result.isSuccess, equals(true));
      expect(result.value, equals(informacoes));
    });

    test('Erro', () {
      when(
        () => preferences.getStringList('informacoes'),
      ).thenThrow(Exception());

      final result = cache.get();

      expect(result.isSuccess, equals(false));
      expect(result.errorMessage, isA<Exception>());
    });
  });

  group('informacao cache - set -', () {
    test('Ok', () async {
      when(
        () => preferences.setStringList('informacoes', informacoes),
      ).thenAnswer((invocation) async => true);

      final result = await cache.set(informacoes);

      expect(result.isSuccess, equals(true));
      expect(result.value, equals(true));
    });

    test('Erro', () async {
      when(
        () => preferences.setStringList('informacoes', informacoes),
      ).thenThrow(Exception());

      final result = await cache.set(informacoes);

      expect(result.isSuccess, equals(false));
      expect(result.errorMessage, isA<Exception>());
    });
  });
}
