import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const ButtonWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xFF44bd6e)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
