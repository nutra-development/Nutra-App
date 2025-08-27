import 'package:flutter/material.dart';

class CategoriaMiniBoxWidget extends StatelessWidget {
  final String nome;
  final Color corFundo;
  final IconData icone;

  const CategoriaMiniBoxWidget({
    super.key,
    required this.nome,
    required this.corFundo,
    this.icone = Icons.category, // ícone padrão
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 30, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            nome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
