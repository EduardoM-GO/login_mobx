import 'package:flutter_result/flutter_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/app/modulos/informacao/cache/informacao_cache.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_state.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_store.dart';
import 'package:mocktail/mocktail.dart';

class _MockInformacaoCache extends Mock implements InformacaoCache {}

void main() {
  late InformacaoCache cache;
  late InformacaoStore store;
  late Exception erro;

  late List<String> informacoes;

  setUp(() {
    cache = _MockInformacaoCache();
    store = InformacaoStore(cache);
    erro = Exception();
    informacoes = List.generate(10, (index) => '$index');
  });
  group('informacao store - obterInformacoes -', () {
    test('OK', () {
      when(
        () => cache.get(),
      ).thenReturn(Result.success(informacoes));

      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoSucessoState(informacoes)));
      });
      store.obterInformacoes();
    });
    test('Erro', () {
      when(
        () => cache.get(),
      ).thenReturn(Result.error(erro));

      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoErroState(erro)));
      });
      store.obterInformacoes();
    });
  });
  group('informacao store - gravaInformacoes -', () {
    test('OK', () {
      when(
        () => cache.set(informacoes),
      ).thenAnswer((_) async => Result.success(true));

      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoSucessoState(informacoes)));
      });
      store.gravaInformacoes(informacoes);
    });
    test('Erro', () {
      when(
        () => cache.set(informacoes),
      ).thenAnswer((_) async => Result.error(erro));

      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoErroState(erro)));
      });
      store.gravaInformacoes(informacoes);
    });
  });
}
