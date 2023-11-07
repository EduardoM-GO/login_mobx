import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:login_mobx/app/modulos/login/datasources/api.dart';
import 'package:login_mobx/app/modulos/login/datasources/login_datasource.dart';
import 'package:login_mobx/app/modulos/login/store/login_state.dart';
import 'package:login_mobx/app/modulos/login/store/login_store.dart';
import 'package:login_mobx/app/modulos/login/validadores/senha_validador.dart';
import 'package:login_mobx/app/modulos/login/validadores/usuario_validador.dart';
import 'package:login_mobx/app/modulos/login/widgets/input_widget.dart';
import 'package:login_mobx/app/widgets/dialogs_widget.dart';
import 'package:login_mobx/app/widgets/scaffold_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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

  late bool logando;

  @override
  void initState() {
    super.initState();
    formkey = GlobalKey<FormState>();
    usuario = '';
    senha = '';
    logando = false;
    injetarDependencia();
    store = GetIt.I.get<LoginStore>();

    scheduleMicrotask(() {
      store.state.observe((value) {
        final state = value.newValue;
        setState(() {
          logando = state is LoginCarregandoState;
        });
        if (state is LoginSucessoState) {
          if (state.logado) {
            ///proxima pagina
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              InputWidget(
                titulo: 'Usuário',
                qtdCaracterMax: 20,
                validator: UsuarioValidador().call,
                onChanged: (value) => usuario = value,
                icon: Icons.person,
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              ElevatedButton(
                onPressed: logando ? null : logar,
                child: logando
                    ? const CircularProgressIndicator()
                    : const Text('Entrar'),
              ),
              const Expanded(child: SizedBox()),
              TextButton(
                  onPressed: irParaPoliticaPrivacidade,
                  child: const Text('Política de privacidade'))
            ],
          ),
        ),
      ),
    );
  }

  void injetarDependencia() {
    GetIt.I.registerFactory<LoginDatasource>(() => LoginDatasourceImpl(Api()));
    GetIt.I.registerSingleton<LoginStore>(LoginStore(GetIt.I()));
  }

  void logar() {
    if (formkey.currentState?.validate() ?? false) {
      store.logar(usuario: usuario.trimRight(), senha: senha.trimRight());
    }
  }

  void irParaPoliticaPrivacidade() async {
    await launchUrl(Uri.parse('https://www.google.com/'));
  }
}
