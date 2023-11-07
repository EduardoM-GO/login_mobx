class Api {
  Future<int> call({required String usuario, required String senha}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (usuario == 'teste' && senha == '123456') {
      return 200;
    }
    return 401;
  }
}
