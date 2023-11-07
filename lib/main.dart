import 'package:flutter/material.dart';
import 'package:prova_flutter/app/modulos/login/login_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Prova flutter',
    initialRoute: '/',
    routes: {'/': (_) => const LoginPage()},
  ));
}
