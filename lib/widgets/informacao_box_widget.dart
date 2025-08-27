import 'package:flutter/material.dart';
import 'package:nutra_app/widgets/nutra_botao_widget.dart';

class InformacaoBoxWidget extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String infoExtra;
  final String textoBotao;
  final VoidCallback onPressed;

  const InformacaoBoxWidget({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.infoExtra,
    required this.textoBotao,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Conteúdo da esquerda
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      subtitulo,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Text(
                  infoExtra,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18), // Espaço entre texto e botão

          // Botão na parte de baixo alinhado verticalmente
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NutraBotaoWidget(
                texto: textoBotao,
                onPressed: onPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}