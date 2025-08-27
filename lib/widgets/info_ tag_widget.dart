import 'package:flutter/material.dart';

class InfoTagWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color cor;

  const InfoTagWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: cor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: cor, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
