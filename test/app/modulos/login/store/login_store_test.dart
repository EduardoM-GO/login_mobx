import 'package:flutter_result/flutter_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/app/modulos/login/datasources/login_datasource.dart';
import 'package:login_mobx/app/modulos/login/store/login_state.dart';
import 'package:login_mobx/app/modulos/login/store/login_store.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoginDatasource extends Mock implements LoginDatasource {}

void main() {
  late String usuario;
  late String senha;
  late Exception erro;

  setUpAll(() {
    usuario = 'test';
    senha = '1234';
    erro = Exception();
  });

  late LoginDatasource datasource;
  late LoginStore store;

  setUp(() {
    datasource = _MockLoginDatasource();
    store = LoginStore(datasource);
  });

  group('login store - Ok -', () {
    test('Logado', () async {
      when(
        () => datasource(usuario: usuario, senha: senha),
      ).thenAnswer((invocation) async => Result.success(true));

      expect(store.state.value, equals(LoginInicialState()));

      await store.logar(usuario: usuario, senha: senha);
      expect(store.state.value, equals(LoginSucessoState(true)));
    });

    test('Recusado', () async {
      when(
        () => datasource(usuario: usuario, senha: senha),
      ).thenAnswer((invocation) async => Result.success(false));

      expect(store.state.value, equals(LoginInicialState()));

      await store.logar(usuario: usuario, senha: senha);
      expect(store.state.value, equals(LoginSucessoState(false)));
    });
  });

  test('login store - Erro', () async {
    when(
      () => datasource(usuario: usuario, senha: senha),
    ).thenAnswer((invocation) async => Result.error(erro));

    expect(store.state.value, equals(LoginInicialState()));

    await store.logar(usuario: usuario, senha: senha);
    expect(store.state.value, equals(LoginErroState(erro)));
  });
}
