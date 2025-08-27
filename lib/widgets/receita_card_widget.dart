import 'package:flutter/material.dart';
import 'info_ tag_widget.dart';

class ReceitaCardWidget extends StatelessWidget {
  final String nomeReceita;
  final String nomeUsuario;
  final String? imagem;
  final int dificuldade;
  final int duracaoMin;

  const ReceitaCardWidget({
    super.key,
    required this.nomeReceita,
    required this.nomeUsuario,
    this.imagem,
    required this.dificuldade,
    required this.duracaoMin,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem com largura flexível
          Container(
            height: 155,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(
                  imagem ?? 'assets/sistema/ImagemNDisponivel.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 155),
            child: Text.rich(
              TextSpan(
                text: nomeReceita,
                children: const [
                  TextSpan(text: '\n\u200B'), // força a segunda linha com espaço invisível
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.3),
            ),
          ),

          Text(
            '@$nomeUsuario',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              InfoTagWidget(
                icon: Icons.bar_chart,
                label: 'Nível $dificuldade',
                cor: const Color.fromARGB(255, 224, 141, 16),
              ),
              const SizedBox(width: 8),
              InfoTagWidget(
                icon: Icons.timer,
                label: '$duracaoMin min',
                cor: const Color.fromARGB(255, 15, 101, 172),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
