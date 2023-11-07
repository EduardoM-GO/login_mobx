class SenhaValidador {
  String? call(String? value) {
    final input = (value ?? '').trimRight();
    if (input.isEmpty) {
      return 'Senha é obrigatório';
    }
    if (input.length < 2) {
      return 'Senha deve ter no mínimo 2 caracteres';
    }
    return null;
  }
}
