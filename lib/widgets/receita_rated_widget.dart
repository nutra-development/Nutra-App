import 'package:flutter/material.dart';

class ReceitaRatedWidget extends StatelessWidget {
  final String? imagePath;
  final String titulo;
  final double rating;

  const ReceitaRatedWidget({
    super.key,
    required this.imagePath,
    required this.titulo,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 3 / 2, // ou qualquer proporção desejada
            child: imagePath != null && imagePath!.isNotEmpty
                ? Image.network(
                    imagePath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/sistema/ImagemNDisponivel.png',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/sistema/ImagemNDisponivel.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          titulo,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            ...List.generate(5, (index) {
              if (rating >= index + 1) {
                return const Icon(Icons.star, color: Colors.amber, size: 20);
              } else if (rating > index && rating < index + 1) {
                return const Icon(Icons.star_half, color: Colors.amber, size: 20);
              } else {
                return const Icon(Icons.star_border, color: Colors.amber, size: 20);
              }
            }),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
