import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:login_mobx/app/modulos/login/store/login_state.dart';
import 'package:login_mobx/app/modulos/login/store/login_store.dart';
import 'package:login_mobx/app/modulos/login/validadores/senha_validador.dart';
import 'package:login_mobx/app/modulos/login/validadores/usuario_validador.dart';
import 'package:login_mobx/app/modulos/login/widgets/button_widget.dart';
import 'package:login_mobx/app/modulos/login/widgets/input_widget.dart';
import 'package:login_mobx/app/widgets/dialogs_widget.dart';
import 'package:login_mobx/app/widgets/scaffold_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> formkey;

  late String usuario;
  late String senha;
  late LoginStore store;

  @override
  void initState() {
    super.initState();
    formkey = GlobalKey<FormState>();
    usuario = '';
    senha = '';
    store = GetIt.I.get<LoginStore>();

    scheduleMicrotask(() {
      adicionarObserver(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const Expanded(flex: 2, child: SizedBox()),
            InputWidget(
              titulo: 'Usuário',
              qtdCaracterMax: 20,
              validator: UsuarioValidador().call,
              onChanged: (value) => usuario = value,
              icon: Icons.person,
            ),
            const SizedBox(
              height: 8,
            ),
            InputWidget(
              titulo: 'Senha',
              qtdCaracterMax: 20,
              validator: SenhaValidador().call,
              onChanged: (value) => senha = value,
              icon: Icons.lock_outline_rounded,
              senha: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\w\d]*'))
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            ButtonWidget(text: 'Entrar', onTap: logar),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  void adicionarObserver(BuildContext context) {
    store.state.observe((value) {
      final state = value.newValue;

      if (state is LoginCarregandoState) {
        DialogsWidget.loading(
            context: context, title: 'Login', message: 'Logando ...');
        return;
      }

      if (value.oldValue is LoginCarregandoState &&
          state is! LoginCarregandoState) {
        ///Fecha o dialog de loading
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      }

      if (state is LoginSucessoState) {
        if (state.logado) {
          Navigator.of(context).popAndPushNamed('/informacao');
          return;
        }

        DialogsWidget.warning(
            context: context, message: 'Usuário ou senha incorreto!');
        return;
      }
      if (state is LoginErroState) {
        DialogsWidget.warning(
          context: context,
          title: 'Erro',
          message: state.erro.toString(),
        );
      }
    });
  }

  void logar() {
    if (formkey.currentState?.validate() ?? false) {
      store.logar(usuario: usuario.trimRight(), senha: senha.trimRight());
    }
  }
}
