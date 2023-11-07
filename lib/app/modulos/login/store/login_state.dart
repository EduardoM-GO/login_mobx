import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInicialState extends LoginState {}

class LoginCarregandoState extends LoginState {}

class LoginSucessoState extends LoginState {
  final bool logado;

  LoginSucessoState(this.logado);

  @override
  List<Object> get props => [logado];
}

class LoginErroState extends LoginState {
  final Exception erro;

  LoginErroState(this.erro);
  @override
  List<Object> get props => [erro];
}
