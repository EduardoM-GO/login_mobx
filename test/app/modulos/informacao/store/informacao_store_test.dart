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

      expect(store.informacoesBase, equals([]));
      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoSucessoState()));
        expect(store.informacoesBase, equals(informacoes));
      });
      store.obterInformacoes();
    });
    test('Erro', () {
      when(
        () => cache.get(),
      ).thenReturn(Result.error(erro));

      expect(store.informacoesBase, equals([]));
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
  group('informacao store - inserir -', () {
    test('OK', () {
      when(
        () => cache.set(['teste1']),
      ).thenAnswer((_) async => Result.success(true));

      expect(store.informacoesBase, equals([]));
      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoSucessoState()));
        expect(store.informacoesBase, equals(['teste1']));
      });
      store.inserir('teste1');
    });
    test('Erro', () {
      when(
        () => cache.set(['teste1']),
      ).thenAnswer((_) async => Result.error(erro));
      expect(store.informacoesBase, equals([]));
      expect(store.state.value, equals(InformacaoInicialState()));
      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoErroState(erro)));
      });
      store.inserir('teste1');
    });
  });

  group('informacao store - editar -', () {
    late List<String> original;
    late List<String> esperado;

    setUp(() {
      original = List.generate(10, (index) => '$index');
      esperado = original;
      esperado[3] = 'teste';

      store.informacoesBase = original;
    });

    test('OK', () {
      when(
        () => cache.set(esperado),
      ).thenAnswer((_) async => Result.success(true));

      expect(store.informacoesBase, equals(original));
      expect(store.state.value, equals(InformacaoInicialState()));

      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoSucessoState()));
        expect(store.informacoesBase, equals(esperado));
      });
      store.editar(index: 3, texto: 'teste');
    });
    test('Erro', () {
      when(
        () => cache.set(esperado),
      ).thenAnswer((_) async => Result.error(erro));

      expect(store.informacoesBase, equals(original));
      expect(store.state.value, equals(InformacaoInicialState()));

      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoErroState(erro)));
      });
      store.editar(index: 3, texto: 'teste');
    });
  });

  group('informacao store - remover -', () {
    late List<String> original;
    late List<String> esperado;

    setUp(() {
      original = List.generate(10, (index) => '$index');
      esperado = original;
      esperado.removeAt(4);

      store.informacoesBase = original;
    });

    test('OK', () {
      when(
        () => cache.set(esperado),
      ).thenAnswer((_) async => Result.success(true));

      expect(store.informacoesBase, equals(original));
      expect(store.state.value, equals(InformacaoInicialState()));

      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoSucessoState()));
        expect(store.informacoesBase, equals(esperado));
      });
      store.remover(4);
    });
    test('Erro', () {
      when(
        () => cache.set(esperado),
      ).thenAnswer((_) async => Result.error(erro));

      expect(store.informacoesBase, equals(original));
      expect(store.state.value, equals(InformacaoInicialState()));

      store.state.observe((value) {
        if (value.oldValue is InformacaoInicialState) {
          expect(value.newValue, equals(InformacaoCarregandoState()));
          return;
        }
        expect(value.newValue, equals(InformacaoErroState(erro)));
      });
      store.remover(4);
    });
  });
}
