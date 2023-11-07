import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  const ScaffoldWidget(
      {super.key, this.appBar, required this.body, this.floatingActionButton});

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
            Color(0xFF1e4e62),
            Color(0xFF2e968f),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: body),
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                    onPressed: irParaPoliticaPrivacidade,
                    child: const Text(
                      'Política de privacidade',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        wordSpacing: 1,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }

  void irParaPoliticaPrivacidade() async {
    await launchUrl(Uri.parse('https://www.google.com/'));
  }
}
