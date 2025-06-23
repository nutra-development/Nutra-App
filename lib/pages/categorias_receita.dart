import 'package:flutter/material.dart';
import '../constants/composto_constants.dart';
import '../categories_component_widget.dart';

class CategoriasReceita extends StatelessWidget {
  const CategoriasReceita({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,  // Tornando o fundo transparente
      elevation: 0,  // Remove a sombra
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded),  // Ícone de "voltar"
        iconSize: 30.0,
        onPressed: () {
          // ação de voltar
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.abc_rounded),  // Ícone de exclamação
          iconSize: 30.0,
          onPressed: () {
            // ação do ícone
          },
        ),
      ],
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categorias",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Selecione uma ou mais categorias para pesquisar as receitas relacionadas a elas",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1,
                children: CompostoConstants.categoriasAlimentares.map((categoria) {
                  return CategoriesComponentWidget(
                    nome: categoria.nome,
                    imagem: categoria.imagem,
                    corFundo: categoria.corFundo,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
