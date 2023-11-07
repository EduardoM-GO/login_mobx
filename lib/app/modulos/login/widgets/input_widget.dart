import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnChanged = void Function(String value);

typedef Validator = String? Function(String? value);

class InputWidget extends StatelessWidget {
  final String titulo;
  final String? valorInicial;
  final IconData? icon;
  final OnChanged onChanged;
  final Validator? validator;
  final int? qtdCaracterMax;
  final List<TextInputFormatter>? inputFormatters;
  final bool senha;

  const InputWidget({
    super.key,
    required this.titulo,
    this.valorInicial,
    this.icon,
    required this.onChanged,
    this.validator,
    this.qtdCaracterMax,
    this.inputFormatters,
    this.senha = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            titulo,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        TextFormField(
          initialValue: valorInicial,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: icon != null ? Icon(icon) : null,
              counterStyle: const TextStyle(color: Colors.white)),
          onChanged: onChanged,
          validator: validator,
          maxLength: qtdCaracterMax,
          inputFormatters: inputFormatters,
          obscureText: senha,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
