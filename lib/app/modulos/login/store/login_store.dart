import 'package:login_mobx/app/modulos/login/datasources/login_datasource.dart';
import 'package:login_mobx/app/modulos/login/store/login_state.dart';
import 'package:mobx/mobx.dart';

class LoginStore {
  final LoginDatasource datasource;
  LoginStore(this.datasource);

  final Observable<LoginState> state = Observable(LoginInicialState());

  Future<void> logar({required String usuario, required String senha}) async {
    state.value = LoginCarregandoState();
    final result = await datasource(usuario: usuario, senha: senha);

    if (result.isSuccess) {
      state.value = LoginSucessoState(result.value ?? false);
      return;
    }

    state.value = LoginErroState(result.errorMessage!);
  }
}
