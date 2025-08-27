import 'package:flutter/material.dart';

typedef RemoverFiltro = void Function(String chave);

class ResumoFiltrosWidget extends StatelessWidget {
  final Map<String, String?> filtrosAtivos;
  final RemoverFiltro onRemover;
  final VoidCallback onLimparTudo;

  const ResumoFiltrosWidget({
    super.key,
    required this.filtrosAtivos,
    required this.onRemover,
    required this.onLimparTudo,
  });

  @override
  Widget build(BuildContext context) {
    final chips = filtrosAtivos.entries
        .where((e) => e.value != null && e.value!.isNotEmpty)
        .map((e) {
      return Chip(
        label: Text('${e.key}: ${e.value}'),
        onDeleted: () => onRemover(e.key),
      );
    }).toList();

    if (chips.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: chips,
            ),
          ),
          TextButton.icon(
            onPressed: onLimparTudo,
            icon: const Icon(Icons.clear_all),
            label: const Text('Limpar todos'),
          ),
        ],
      ),
    );
  }
}
