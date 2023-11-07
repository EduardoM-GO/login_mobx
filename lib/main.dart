import 'package:flutter/material.dart';
import 'package:login_mobx/app/modulos/login/login_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Prova flutter',
    initialRoute: '/',
    routes: {'/': (_) => const LoginPage()},
  ));
}
