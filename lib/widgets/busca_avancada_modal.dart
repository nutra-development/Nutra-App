import 'package:flutter/material.dart';
import 'package:nutra_app/functions/functions.dart';

class BuscaAvancadaModal extends StatefulWidget {
  final Map<String, List<String>> filtrosDisponiveis;
  final Map<String, List<String>> filtrosSelecionados;
  final void Function(Map<String, List<String>>) onAplicar;

  const BuscaAvancadaModal({
    super.key,
    required this.filtrosDisponiveis,
    required this.filtrosSelecionados,
    required this.onAplicar,
  });

  @override
  State<BuscaAvancadaModal> createState() => _BuscaAvancadaModalState();
}

class _BuscaAvancadaModalState extends State<BuscaAvancadaModal> {
  
  final Map<String, List<String>> _filtrosSelecionados = {};

  @override
  void initState() {
    super.initState();
    _filtrosSelecionados.addAll(widget.filtrosSelecionados.map(
      (key, value) => MapEntry(key, List.from(value)),
    ));
  }

  Widget _buildFiltroChips(String label, String chave) {
    final opcoes = widget.filtrosDisponiveis[chave] ?? [];
    final selecionados = _filtrosSelecionados[chave] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: opcoes.map((item) {
            final estaSelecionado = selecionados.contains(item);
            return FilterChip(
              label: Text(item),
              selected: estaSelecionado,
              onSelected: (_) {
                setState(() {
                  if (estaSelecionado) {
                    selecionados.remove(item);
                  } else {
                    selecionados.add(item);
                  }
                  _filtrosSelecionados[chave] = List.from(selecionados);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final chave in widget.filtrosDisponiveis.keys)
              _buildFiltroChips(formatarTitulo(chave), chave),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onAplicar(_filtrosSelecionados);
                },
                icon: const Icon(Icons.check),
                label: const Text("Aplicar filtros"),
              ),
            )
          ],
        ),
      ),
    );
  }
}