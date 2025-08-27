import 'package:flutter/material.dart';

class OrdenacaoRceitaModal extends StatefulWidget {
  const OrdenacaoRceitaModal({super.key});

  @override
  State<OrdenacaoRceitaModal> createState() => _OrdenacaoRceitaModalState();
}

class _OrdenacaoRceitaModalState extends State<OrdenacaoRceitaModal> {
  String? _selecionado;

  final List<Map<String, dynamic>> opcoesOrdenacao = [
    {'titulo': 'Nota', 'valor': 'rating', 'icone': Icons.star},
    {'titulo': 'Tempo', 'valor': 'tempo', 'icone': Icons.timer},
    {'titulo': 'Dificuldade', 'valor': 'dificuldade', 'icone': Icons.fitness_center},
    {'titulo': 'Faixa etária', 'valor': 'faixaEtaria', 'icone': Icons.child_care},
    {'titulo': 'Rendimento', 'valor': 'rendimento', 'icone': Icons.restaurant},
    {'titulo': 'Favoritos', 'valor': 'favoritos', 'icone': Icons.favorite},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Limpa a seleção se clicar fora das opções
            if (_selecionado != null) {
              setState(() {
                _selecionado = null;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                // Indicador superior preto
                Container(
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 120, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 160, 160, 160),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                // Grade de 2 linhas com 3 colunas cada
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30), // espaço entre o container cinza e os botões
                    _buildLinha(0),
                    const SizedBox(height: 20),
                    _buildLinha(3),
                  ],
                ),

                const SizedBox(height: 80),

                if (_selecionado != null)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(_selecionado);
                      },
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLinha(int startIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (i) {
        int index = startIndex + i;
        if (index >= opcoesOrdenacao.length) return const SizedBox();

        final item = opcoesOrdenacao[index];
        final bool isSelecionado = _selecionado == item['valor'];

        final double iconSize = isSelecionado ? 36 : 30;
        final double circleSize = isSelecionado ? 70 : 60;
        final double fontSize = isSelecionado ? 16 : 14;
        final Color borderColor = isSelecionado
            ? Colors.deepPurple
            : const Color.fromARGB(255, 155, 155, 155);
        final Color iconColor = borderColor;
        final Color backgroundColor = isSelecionado
            ? Colors.deepPurple.withOpacity(0.1)
            : Colors.transparent;

        return Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                if (_selecionado == item['valor']) {
                  _selecionado = null;
                } else {
                  _selecionado = item['valor'];
                }
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 2),
                    color: backgroundColor,
                  ),
                  child: Icon(
                    item['icone'],
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.black,
                    ),
                    child: Text(
                      item['titulo'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
