import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnChanged = void Function(String value);

typedef Validator = String? Function(String? value);

class InputWidget extends StatelessWidget {
  final String? titulo;
  final String? valorInicial;
  final IconData? icon;
  final OnChanged? onChanged;
  final Validator? validator;
  final int? qtdCaracterMax;
  final List<TextInputFormatter>? inputFormatters;
  final bool senha;
  final Widget? suffixIcon;
  final bool autoFocus;
  final FocusNode? focus;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final bool ativarBorda;
  final String? hintText;

  const InputWidget(
      {super.key,
      this.titulo,
      this.valorInicial,
      this.icon,
      this.onChanged,
      this.validator,
      this.qtdCaracterMax,
      this.inputFormatters,
      this.senha = false,
      this.suffixIcon,
      this.autoFocus = false,
      this.focus,
      this.onEditingComplete,
      this.controller,
      this.ativarBorda = false,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titulo != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              titulo!,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        TextFormField(
          controller: controller,
          focusNode: focus,
          autofocus: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: valorInicial,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                  borderSide:
                      ativarBorda ? const BorderSide() : BorderSide.none),
              prefixIcon: icon != null ? Icon(icon) : null,
              counterStyle: const TextStyle(color: Colors.white),
              suffixIcon: suffixIcon),
          onChanged: onChanged,
          validator: validator,
          maxLength: qtdCaracterMax,
          inputFormatters: inputFormatters,
          obscureText: senha,
          onTapOutside:
              autoFocus ? null : (event) => FocusScope.of(context).unfocus(),
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }
}
