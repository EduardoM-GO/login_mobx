import 'package:flutter/foundation.dart';
import 'package:login_mobx/app/modulos/informacao/cache/informacao_cache.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_state.dart';
import 'package:mobx/mobx.dart';

class InformacaoStore {
  final Observable<InformacaoState> state =
      Observable(InformacaoInicialState());
      
  @visibleForTesting
  List<String> informacoesBase = [];

  List<String> get informacoes => informacoesBase;

  final InformacaoCache cache;
  InformacaoStore(this.cache) {
    obterInformacoes = Action(_obterInformacoes);
  }

  late Action obterInformacoes;

  void _obterInformacoes() {
    state.value = InformacaoCarregandoState();

    final result = cache.get();

    if (result.isSuccess) {
      informacoesBase = result.value!;
      state.value = InformacaoSucessoState();
      return;
    }
    state.value = InformacaoErroState(result.errorMessage!);
  }

  Future<void> inserir(String texto) async {
    state.value = InformacaoCarregandoState();
    informacoesBase.add(texto);
    final result = await cache.set(informacoesBase);

    if (result.isSuccess) {
      state.value = InformacaoSucessoState();
      return;
    }
    state.value = InformacaoErroState(result.errorMessage!);
  }

  Future<void> editar({required int index, required String texto}) async {
    state.value = InformacaoCarregandoState();
    informacoesBase[index] = texto;
    final result = await cache.set(informacoesBase);

    if (result.isSuccess) {
      state.value = InformacaoSucessoState();
      return;
    }
    state.value = InformacaoErroState(result.errorMessage!);
  }

  Future<void> remover(int index) async {
    state.value = InformacaoCarregandoState();
    informacoesBase.removeAt(index);
    final result = await cache.set(informacoesBase);

    if (result.isSuccess) {
      state.value = InformacaoSucessoState();
      return;
    }
    state.value = InformacaoErroState(result.errorMessage!);
  }
}
