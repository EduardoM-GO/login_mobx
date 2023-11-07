import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_state.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_store.dart';
import 'package:login_mobx/app/modulos/login/widgets/input_widget.dart';
import 'package:login_mobx/app/widgets/dialogs_widget.dart';
import 'package:login_mobx/app/widgets/scaffold_widget.dart';

class InformacaoPage extends StatefulWidget {
  const InformacaoPage({super.key});

  @override
  State<InformacaoPage> createState() => _InformacaoPageState();
}

class _InformacaoPageState extends State<InformacaoPage> {
  List<String> informacoes = [];
  late final InformacaoStore store;
  late final FocusNode focusNode;

  late String texto;

  @override
  void initState() {
    super.initState();
    store = GetIt.I.get<InformacaoStore>();
    focusNode = FocusNode();
    texto = '';
    scheduleMicrotask(() {
      adicionarObserver(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: ListView.separated(
                  itemBuilder: (context, index) => Text(informacoes[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: informacoes.length),
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Form(
            child: InputWidget(
              autoFocus: true,
              focus: focusNode,
              onChanged: (value) {
                texto = value;
              },
              suffixIcon: const Icon(Icons.save),
            ),
          )
        ],
      ),
    );
  }

  void adicionarObserver(BuildContext context) {
    store.state.observe((value) {
      final state = value.newValue;

      if (state is InformacaoCarregandoState) {
        DialogsWidget.loading(
            context: context, title: 'Login', message: 'Logando ...');
        return;
      }

      if (value.oldValue is InformacaoCarregandoState &&
          state is! InformacaoCarregandoState) {
        ///Fecha o dialog de loading
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      }

      if (state is InformacaoSucessoState) {
        setState(() {
          informacoes = state.informacoes;
        });
      }
      if (state is InformacaoErroState) {
        DialogsWidget.warning(
          context: context,
          title: 'Erro',
          message: state.erro.toString(),
        );
      }
    });
  }
 
}
