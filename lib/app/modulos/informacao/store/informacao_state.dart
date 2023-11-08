import 'package:equatable/equatable.dart';

sealed class InformacaoState extends Equatable {
  @override
  List<Object> get props => [];
}

class InformacaoInicialState extends InformacaoState {}

class InformacaoCarregandoState extends InformacaoState {}

class InformacaoSucessoState extends InformacaoState {}

class InformacaoErroState extends InformacaoState {
  final Exception erro;

  InformacaoErroState(this.erro);

  @override
  List<Object> get props => [erro];
}
