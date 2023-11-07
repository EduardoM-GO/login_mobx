import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;

  const ScaffoldWidget(
      {super.key, this.appBar, this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    ///Contém o Gesture Detector para minimizar o teclado quando
    ///clicado fora do campo digitavel
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
