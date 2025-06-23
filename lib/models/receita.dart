// lib/models/receita.dart

class Receita {
  final String id;
  final String nome;

  Receita({required this.id, required this.nome});

  // Método para converter documento do Firestore em Receita
  factory Receita.fromDocument(Map<String, dynamic> data, String id) {
    return Receita(
      id: id,
      nome: data['nome'] ?? '',
    );
  }
}
