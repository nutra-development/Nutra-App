import 'package:flutter/material.dart';

class CategoriesComponentWidget extends StatelessWidget {
  final String nome;
  final String imagem;
  final Color corFundo;

  const CategoriesComponentWidget({
    super.key,
    required this.nome,
    required this.imagem,
    required this.corFundo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: corFundo,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final largura = constraints.maxWidth;
            final tamanhoImagem = largura * 1; // ou altura * 0.75, se preferir

            return Stack(
              children: [
                /// Imagem ocupando 75% da largura do container
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: Image.asset(
                    imagem,
                    width: tamanhoImagem,
                    height: tamanhoImagem,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 45),
                  ),
                ),

                /// Texto centralizado
                Positioned(
                  top: 8,
                  left: 15,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 150, // define o limite máximo, mas permite quebrar se couber
                    ),
                    child: Text(
                      nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
