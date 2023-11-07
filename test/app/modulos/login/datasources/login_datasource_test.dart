import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/app/modulos/login/datasources/api.dart';
import 'package:login_mobx/app/modulos/login/datasources/login_datasource.dart';
import 'package:mocktail/mocktail.dart';

class _MockApi extends Mock implements Api {}

void main() {
  late String usuario;
  late String senha;

  setUpAll(() {
    usuario = 'test';
    senha = '1234';
  });

  late Api api;
  late LoginDatasource datasource;

  setUp(() {
    api = _MockApi();
    datasource = LoginDatasourceImpl(api);
  });

  group('login datasource - ok -', () {
    test('Logado', () async {
      when(
        () => api(usuario: usuario, senha: senha),
      ).thenAnswer((invocation) async => 200);

      final result = await datasource(usuario: usuario, senha: senha);

      expect(result.isSuccess, equals(true));
      expect(result.value, equals(true));
    });
    test('Recusado', () async {
      when(
        () => api(usuario: usuario, senha: senha),
      ).thenAnswer((invocation) async => 401);

      final result = await datasource(usuario: usuario, senha: senha);

      expect(result.isSuccess, equals(true));
      expect(result.value, equals(false));
    });
  });

  test('login datasource - Erro', () async {
    when(
      () => api(usuario: usuario, senha: senha),
    ).thenThrow(Exception());

    final result = await datasource(usuario: usuario, senha: senha);

    expect(result.isSuccess, equals(false));
    expect(result.errorMessage, isA<Exception>());
  });
}
