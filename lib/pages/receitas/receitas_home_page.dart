import 'package:flutter/material.dart';
import 'package:nutra_app/pages/receitas/receitas_search_page.dart';
import '../../widgets/widgets.dart';
import '../../constants/propriedades_alimentares_constants.dart';
import '../receitas/categorias_receita_page.dart';
import '../../models/receita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceitasHomePage extends StatelessWidget {
  const ReceitasHomePage({super.key});

    Future<List<Receita>> _carregarReceitas() async {
    final snapshot = await FirebaseFirestore.instance.collection('receita').get();

    return snapshot.docs.map((doc) {
      return Receita.fromDocument(doc.data(), doc.id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NutraCustomBar(
        // Botão à esquerda
        leadingIcon: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.deepPurple,
            size: 32,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        // Botão à direita
        actionIcon: IconButton(
          icon: const Icon(
            Icons.contact_phone,
            color: Colors.orange,
            size: 28,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceitasSearchPage(),
              ),
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Saudações
              const Text(
                "Olá Usuário",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Seja bem-vindo ao menu de receitas",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              // Seção 1 - ex: chamadas    
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InformacaoBoxWidget(
                      titulo: 'Monte seu',
                      subtitulo: 'Plano Alimentar',
                      infoExtra: 'Explore nosso menu e crie um plano alimentar que combina com você',
                      textoBotao: 'Começar',
                      onPressed: () {
                        // ação do botão
                      },
                    ),
                    SizedBox(width: 15), // espaçamento entre os itens
                    InformacaoBoxWidget(
                      titulo: 'Parte 1',
                      subtitulo: 'Parte 2',
                      infoExtra: 'Fonte de fibras',
                      textoBotao: 'Ver mais',
                      onPressed: () {
                        // ação do botão
                      },
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // Seção 2 – ex: categorias
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Categorias",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CategoriasReceita(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Ver mais",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      
                    ]
                  ),

                  SizedBox(height: 5),
                  // Aqui pode entrar uma lista horizontal de categorias
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: PropriedadesAlimentaresConstants.categoriasAlimentares
                          .take(7)
                          .map((categoria) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CategoriaMiniBoxWidget(
                                nome: categoria.nome,
                                corFundo: categoria.corFundo,
                              ),
                            );
                          }).toList(),
                    ),
                  )

                ],
              ),

              const SizedBox(height: 20),

              // Seção 3 – ex: recomendações
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Recomendações para você",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: TextButton(
                          onPressed: () {
                            // ação ao tocar no texto
                            print("Ver mais clicado!");
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Ver mais",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: 10),
                  // Lista de receitas recomendadas

                  FutureBuilder<List<Receita>>(
                    future: _carregarReceitas(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Text('Erro ao carregar receitas');
                      }

                      final receitas = snapshot.data ?? [];

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: receitas.map((receita) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: ReceitaCardWidget(
                                nomeReceita: receita.nome,
                                nomeUsuario: receita.nomeUsuario,
                                // imagem: receita.imagem,
                                dificuldade: receita.dificuldade,
                                duracaoMin: receita.tempoEstimado,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ]
            ),
          ),
        )
        );
      }
    }