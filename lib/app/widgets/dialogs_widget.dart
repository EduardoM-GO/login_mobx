import 'package:flutter/material.dart';
import 'package:login_mobx/app/modulos/informacao/validadores/campo_obrigatorio_validador.dart';
import 'package:login_mobx/app/modulos/login/widgets/input_widget.dart';

//enum DialogLoading { close }

class DialogsWidget {
  DialogsWidget._();

  ///As caixas de diálogo de alerta interrompem os usuários com informações,
  ///detalhes ou ações urgentes.
  static Future<void> alert({
    required BuildContext context,
    String? title,
    required String message,
    required String textLeft,
    VoidCallback? onPressedLeft,
    required String textRight,
    required VoidCallback onPressedRight,
  }) =>
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: title != null ? Text(title) : null,
          content: SingleChildScrollView(child: Text(message)),
          actions: [
            TextButton(
              onPressed: onPressedLeft ?? () => Navigator.pop(context),
              child: Text(textLeft.toUpperCase()),
            ),
            TextButton(
              onPressed: onPressedRight,
              child: Text(textRight.toUpperCase()),
            ),
          ],
        ),
      );

  static Future<void> warning(
      {required BuildContext context, String? title, required String message}) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: SingleChildScrollView(
          child: Text(
            message,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> loading({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(
          24,
          12,
          24,
          16,
        ),

        ///Usado para evitar o usuário feche o dialogo com botão do dispositivo
        title: WillPopScope(
          onWillPop: () async => false,
          child: Text(title),
        ),
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CircularProgressIndicator(),
                ),
                Text(
                  message,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Future<String?> formulario({
    required BuildContext context,
    String? valorInicial,
  }) async {
    String? texto;
    final formKey = GlobalKey<FormState>();
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        content: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputWidget(
                ativarBorda: true,
                valorInicial: valorInicial,
                autoFocus: true,
                onChanged: (value) {
                  texto = value;
                },
                validator: CampoObrigatorioValidador().call,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              texto = null;
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    return texto;
  }
}
