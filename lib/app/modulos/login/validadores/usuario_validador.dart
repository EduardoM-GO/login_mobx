class UsuarioValidador {
  String? call(String? value) {
    final input = (value ?? '').trimRight();
    if (input.isEmpty) {
      return 'Usuário é obrigatório';
    }
    return null;
  }
}
