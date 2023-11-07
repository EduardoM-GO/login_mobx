import 'package:flutter_result/flutter_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InformacaoCache {
  Result<List<String>, Exception> get();
  Future<Result<bool, Exception>> set(List<String> informacoes);
}

class InformacaoCacheImpl implements InformacaoCache {
  static const String key = 'informacoes';
  final SharedPreferences preferences;

  InformacaoCacheImpl(this.preferences);

  @override
  Result<List<String>, Exception> get() {
    try {
      final result = preferences.getStringList(key);
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<bool, Exception>> set(List<String> informacoes) async{
     try {
      final result =  await preferences.setStringList(key,informacoes);
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
