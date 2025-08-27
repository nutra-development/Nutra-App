import 'package:flutter/material.dart';

class NutraBotaoWidget extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final double? largura;
  final double? altura;
  final Color? cor;

  const NutraBotaoWidget({
    super.key,
    required this.texto,
    required this.onPressed,
    this.largura,
    this.altura,
    this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura ?? 100,
      height: altura ?? 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: cor ?? Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal:8, vertical: 8), // <-- Aqui
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size.zero, // garante que padding controle tudo
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
