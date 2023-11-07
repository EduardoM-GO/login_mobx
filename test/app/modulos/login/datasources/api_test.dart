import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/app/modulos/login/datasources/api.dart';

void main() {
  late Api api;
  setUp(() => api = Api());
  test('api - OK', () async {
    final result = await api(usuario: 'teste', senha: '123456');

    expect(result, equals(200));
  });

  group('api - 401 -', () {
    test('Usuario incorreto', () async {
      final result = await api(usuario: 'test', senha: '123456');

      expect(result, equals(401));
    });
    test('senha incorreto', () async {
      final result = await api(usuario: 'teste', senha: '12345');

      expect(result, equals(401));
    });
  });
}
