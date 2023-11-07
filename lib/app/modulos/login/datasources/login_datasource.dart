import 'package:flutter_result/flutter_result.dart';
import 'package:login_mobx/app/modulos/login/datasources/api.dart';

abstract class LoginDatasource {
  Future<Result<bool, Exception>> call(
      {required String usuario, required String senha});
}

class LoginDatasourceImpl implements LoginDatasource {
  final Api api;

  LoginDatasourceImpl(this.api);

  @override
  Future<Result<bool, Exception>> call(
      {required String usuario, required String senha}) async {
    try {
      final responseApi = await api(usuario: usuario, senha: senha);
      final result = responseApi == 200;
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
