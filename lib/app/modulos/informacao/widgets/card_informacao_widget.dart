import 'package:flutter/material.dart';

class CardInformacaoWidget extends StatelessWidget {
  final String texto;
  final Function() editar;
  final Function() excluir;

  const CardInformacaoWidget(
      {super.key,
      required this.texto,
      required this.editar,
      required this.excluir});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(texto)),
          const SizedBox(
            width: 8,
          ),
          IconButton(onPressed: editar, icon: const Icon(Icons.edit)),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              onPressed: excluir,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
