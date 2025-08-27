import 'package:flutter/material.dart';

class OrdenarDropdown extends StatelessWidget {
  final String valorSelecionado;
  final void Function(String?) onChanged;

  const OrdenarDropdown({
    super.key,
    required this.valorSelecionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valorSelecionado,
      onChanged: onChanged,
      items: const [
        DropdownMenuItem(value: 'rating', child: Text('Nota')),
        DropdownMenuItem(value: 'tempo', child: Text('Tempo')),
        DropdownMenuItem(value: 'dificuldade', child: Text('Dificuldade')),
      ],
    );
  }
}
