import 'package:flutter/material.dart';

class CompostoConstants {
  static const List<CategoriaAlimentar> categoriasAlimentares = [
    CategoriaAlimentar(nome: "Açúcares e Doces", imagem: "assets/Categorias/Açúcares&Doces.png", corFundo: Color.fromARGB(255, 156, 103, 78)),
    CategoriaAlimentar(nome: "Aves", imagem: "assets/Categorias/Aves.png", corFundo: Color.fromARGB(255, 185, 158, 82)),
    CategoriaAlimentar(nome: "Carnes Vermelhas", imagem: "assets/Categorias/CarnesVermelhas.png", corFundo: Color.fromARGB(255, 211, 105, 98)),
    CategoriaAlimentar(nome: "Cereais e Derivados", imagem: "assets/Categorias/Cereais&Derivados.png", corFundo: Color(0xFFC77D27)),
    CategoriaAlimentar(nome: "Frutas", imagem: "assets/Categorias/Frutas.png", corFundo: Color.fromARGB(255, 212, 70, 70)),
    CategoriaAlimentar(nome: "Leguminosas", imagem: "assets/Categorias/Leguminosas.png", corFundo: Color.fromARGB(255, 90, 72, 56)),
    CategoriaAlimentar(nome: "Leite e Derivados", imagem: "assets/Categorias/Leite&Derivados.png", corFundo: Color(0xFFFFA69B)),
    CategoriaAlimentar(nome: "Oleaginosas e Sementes", imagem: "assets/Categorias/Oleaginosas&Sementes.png", corFundo: Color.fromARGB(255, 155, 111, 61)),
    CategoriaAlimentar(nome: "Óleos e Gorduras", imagem: "assets/Categorias/Óleos&Gorduras.png", corFundo: Color.fromARGB(255, 101, 167, 62)),
    CategoriaAlimentar(nome: "Ovos", imagem: "assets/Categorias/Ovos.png", corFundo: Color.fromARGB(255, 179, 98, 61)),
    CategoriaAlimentar(nome: "Peixes e Frutos do Mar", imagem: "assets/Categorias/Peixes&FrutosMar.png", corFundo: Color.fromARGB(255, 74, 138, 180)),
    CategoriaAlimentar(nome: "Pseudocereais", imagem: "assets/Categorias/Pseudocereais.png", corFundo: Color.fromARGB(255, 207, 164, 114)),
    CategoriaAlimentar(nome: "Raízes", imagem: "assets/Categorias/Raízes.png", corFundo: Color.fromARGB(255, 21, 95, 89)),
    CategoriaAlimentar(nome: "Tubérculos", imagem: "assets/Categorias/Tubérculos.png", corFundo: Color.fromARGB(255, 218, 107, 87)),
    CategoriaAlimentar(nome: "Vegetais", imagem: "assets/Categorias/Vegetais.png", corFundo: Color.fromARGB(255, 72, 121, 72)),
  ];

  static const List<String> metodosPreparo = [
    "Cru/In natura",
    "Frito",
    "Assado",
    "Grelhado",
    "Cozido",
    "Refogado",
    "Salteado",
    "Braseado",
    "Fermentado",
    "Defumado",
    "Desidratado",
    "Congelado",
    "Batido",
    "Marinado",
    "Imerso",
    "Raso",
    "Gratinado",
    "Lento",
    "Em pasta",
    "Vitamina",
    "Em água",
    "No vapor",
    "Com alho e cebola",
    "Com manteiga",
    "Em molho",
    "Natural",
    "Industrializado",
  ];

  static const List<String> tiposRefeicao = [
    "Liquida",
    "Sólida",
    "Prato principal",
    "Sobremesa",
    "Lanche",
    "Suco funcional",
    "Papinha",
    "Entrada",
    "Sopa / Caldo",
    "Bebida",
    "Complemento",
    "Café da manhã",
    "Petisco",
  ];

  static const List<String> medidasCategorias = [
    "Xícara",
    "Colher de sopa",
    "Colher de chá",
    "Grama (g)",
    "Quilo (kg)",
    "Litro (L)",
    "Mililitro (ml)",
    "Unidade",
    "Pitada",
    "A gosto",
    "Fatia",
    "Concha",
    "Tablete",
    "Copo",
  ];

  static const List<String> modosApresentacao = [
    "Picado",
    "Em cubos",
    "Filetado",
    "Fatiado",
    "Moído",
    "Ralado",
    "Amassado",
    "Inteiro",
    "Desfiado",
    "Triturado",
    "Cortado em tiras",
    "Cortado em rodelas",
    "Em pedaços",
    "Em lascas",
    "Em purê",
    "Em fatias finas",
    "Fervido",
    "Cozido no vapor",
    "Assado",
    "Grelhado",
  ];
}

class CategoriaAlimentar {
  final String nome;
  final String imagem;
  final Color corFundo;

  const CategoriaAlimentar({
    required this.nome,
    required this.imagem,
    required this.corFundo,
  });
}