import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/receita.dart';
import '../../widgets/receita_rated_widget.dart';
import '../../widgets/nutra_app_bar.dart';

class ReceitasRatePage extends StatelessWidget {
  final String nomePesquisa;

  const ReceitasRatePage({super.key, required this.nomePesquisa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NutraAppBar(
        onAction: () {
          // ação de botão
        },
        actionIcon: Icons.help_outline_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 4),
              child: Row(
                children: [
                  Text(
                    'Resultados da pesquisa: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      nomePesquisa.isNotEmpty ? nomePesquisa : '(nenhum termo)',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('receita')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro ao carregar receitas.'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final receitas = snapshot.data!.docs.map((doc) {
                    return Receita.fromDocument(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    );
                  }).toList();

                  if (receitas.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma receita encontrada.'),
                    );
                  }

                  return SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 15,
                        runSpacing: 15,
                        children: receitas.map((receita) {
                          return SizedBox(
                            width: 175,
                            child: ReceitaRatedWidget(
                              imagePath: 'assets/sistema/ImagemNDisponivel.png',
                              titulo: receita.nome,
                              rating: receita.rate,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
