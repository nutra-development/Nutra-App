import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutra_app/pages/receitas/receitas_search_page.dart';

import 'firebase_options.dart';
import 'models/receita.dart';
import 'pages/receitas/categorias_receita_page.dart';
import 'pages/receitas/receitas_rate_page.dart';
import './widgets/receita_rated_widget.dart';
import 'pages/receitas/receitas_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ReceitasPage(),
    );
  }
}

class ReceitasPage extends StatelessWidget {
  const ReceitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔽 Botão de categorias
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriasReceita(),
                    ),
                  );
                },
                child: const Text('Categorias'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReceitasHomePage(),
                    ),
                  );
                },
                child: const Text('HomePage Receitas'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReceitasRatePage(nomePesquisa: 'Em Alta!'),
                    ),
                  );
                },
                child: const Text('Rating'),
              ),
            ),

             Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReceitasSearchPage(),
                    ),
                  );
                },
                child: const Text('Pesquisas'),
              ),
            ),

            /// 🔽 Lista de receitas em Wrap centralizado
            Padding(
              padding: const EdgeInsets.all(8),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('receita')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar receitas.'));
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
                    return const Center(child: Text('Nenhuma receita encontrada.'));
                  }

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
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
