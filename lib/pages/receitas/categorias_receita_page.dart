import 'package:flutter/material.dart';
import '../../constants/propriedades_alimentares_constants.dart';
import '../../widgets/widgets.dart';

class CategoriasReceita extends StatelessWidget {
  const CategoriasReceita({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NutraAppBar(
        onAction: () {
          // ação de botão
        },
        actionIcon: Icons.help_outline_outlined,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título e subtítulo
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Categorias",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Selecione uma ou mais categorias para pesquisar as receitas relacionadas a elas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // Grid de categorias
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1,
                    children: PropriedadesAlimentaresConstants.categoriasAlimentares.map((categoria) {
                      return CategoriaBoxWidget(
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
        ),
      ),
    );
  }
}
