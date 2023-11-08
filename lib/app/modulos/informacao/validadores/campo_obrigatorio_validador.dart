class CampoObrigatorioValidador {
  String? call(String? value) {
    final String texto = value ?? '';

    if (texto.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null;
  }
}
