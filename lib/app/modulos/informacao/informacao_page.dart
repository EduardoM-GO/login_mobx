import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_state.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_store.dart';
import 'package:login_mobx/app/modulos/informacao/validadores/campo_obrigatorio_validador.dart';
import 'package:login_mobx/app/modulos/informacao/widgets/card_informacao_widget.dart';
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

  late final GlobalKey<FormState> formKey;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    store = GetIt.I.get<InformacaoStore>();
    focusNode = FocusNode();
    formKey = GlobalKey<FormState>();
    controller = TextEditingController();
    scheduleMicrotask(() {
      adicionarObserver(context);
      store.obterInformacoes();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  itemBuilder: (context, index) => CardInformacaoWidget(
                        texto: informacoes[index],
                        editar: () async {
                          final result = await DialogsWidget.formulario(
                              context: context,
                              valorInicial: informacoes[index]);

                          if (result != null) {
                            store.editar(index: index, texto: result);
                          }
                        },
                        excluir: () => DialogsWidget.alert(
                          context: context,
                          message: 'Deseja excluir este registro?',
                          textLeft: 'Não',
                          textRight: 'Sim',
                          onPressedRight: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/informacao'));
                            store.remover(index);
                          },
                        ),
                      ),
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 1),
                  itemCount: informacoes.length),
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Form(
            child: Form(
              key: formKey,
              child: InputWidget(
                autoFocus: true,
                hintText: 'Digite seu texto',
                focus: focusNode,
                controller: controller,
                onEditingComplete: salvar,
                suffixIcon:
                    IconButton(onPressed: salvar, icon: const Icon(Icons.save)),
                validator:CampoObrigatorioValidador().call,
              ),
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
            context: context, title: 'Login', message: 'Carregando ...');
        return;
      }

      if (value.oldValue is InformacaoCarregandoState &&
          state is! InformacaoCarregandoState) {
        ///Fecha o dialog de loading
        Navigator.of(context).popUntil(ModalRoute.withName('/informacao'));
      }

      if (state is InformacaoSucessoState) {
        setState(() {
          informacoes = store.informacoes;
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

  void salvar() async {
    if (formKey.currentState?.validate() ?? false) {
      await store.inserir(controller.text);
      controller.text = '';
    }
    focusNode.requestFocus();
  }
}
