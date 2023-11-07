import 'package:login_mobx/app/modulos/informacao/cache/informacao_cache.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_state.dart';
import 'package:mobx/mobx.dart';

class InformacaoStore {
  final Observable<InformacaoState> state =
      Observable(InformacaoInicialState());

  final InformacaoCache cache;
  InformacaoStore(this.cache) {
    obterInformacoes = Action(_obterInformacoes);
  }
  late Action obterInformacoes;

  void _obterInformacoes() {
    state.value = InformacaoCarregandoState();

    final result = cache.get();

    if (result.isSuccess) {
      state.value = InformacaoSucessoState(result.value!);
      return;
    }
    state.value = InformacaoErroState(result.errorMessage!);
  }

  Future<void> gravaInformacoes(List<String> informacoes) async {
    state.value = InformacaoCarregandoState();

    final result = await cache.set(informacoes);

    if (result.isSuccess) {
      state.value = InformacaoSucessoState(informacoes);
      return;
    }
    state.value = InformacaoErroState(result.errorMessage!);
  }
}
