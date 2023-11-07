import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:login_mobx/app/modulos/informacao/cache/informacao_cache.dart';
import 'package:login_mobx/app/modulos/informacao/informacao_page.dart';
import 'package:login_mobx/app/modulos/informacao/store/informacao_store.dart';
import 'package:login_mobx/app/modulos/login/datasources/api.dart';
import 'package:login_mobx/app/modulos/login/datasources/login_datasource.dart';
import 'package:login_mobx/app/modulos/login/login_page.dart';
import 'package:login_mobx/app/modulos/login/store/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerFactory<LoginDatasource>(() => LoginDatasourceImpl(Api()));
  GetIt.I.registerSingleton<LoginStore>(LoginStore(GetIt.I()));
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  GetIt.I
      .registerFactory<InformacaoCache>(() => InformacaoCacheImpl(preferences));
  GetIt.I.registerSingleton<InformacaoStore>(InformacaoStore(GetIt.I()));

  runApp(MaterialApp(
    title: 'Prova flutter',
    initialRoute: '/',
    routes: {
      '/': (_) => const LoginPage(),
      '/informacao': (_) => const InformacaoPage()
    },
  ));
}
