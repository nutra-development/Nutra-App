import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/propriedades_alimentares_constants.dart';

class AlimentoNutraClass {
 String? id;
  String? profileImage;
  String? imagensComplementares;
  String nome;
  List<String> nomesPopulares;
  String formato;
  SentidosPercebidosCarac sentidosPercebidos;
  String tipo;
  List<String> tags;
  DocumentReference valoresNutricionais;
  DocumentReference informacoesUso;
  String grupoAlimentar;
  List<DocumentReference> combinacoes;
  int recomendacaoEtaria;

  AlimentoNutraClass({
    this.id,
    this.profileImage,
    this.imagensComplementares,
    required this.nome,
    required this.nomesPopulares,
    required this.formato,
    required this.sentidosPercebidos,
    required this.tipo,
    required this.tags,
    required this.valoresNutricionais,
    required this.informacoesUso,
    required this.grupoAlimentar,
    required this.combinacoes,
    required this.recomendacaoEtaria,
  }) {
    if (!PropriedadesAlimentaresConstants.categoriasAlimentares
        .any((categoria) => categoria.nome == grupoAlimentar)) {
      throw ArgumentError('Grupo alimentar inválido: $grupoAlimentar');
    }
  }

  void addNomePopular(String nomePopular) {
    final nomeTrimmed = nomePopular.trim();

    if (nomeTrimmed.isEmpty || RegExp(r'\d').hasMatch(nomeTrimmed)) {
      print('Erro ao adicionar nome popular ao alimento $nome');
      return;
    }

    nomesPopulares.add(nomeTrimmed);
    print('Nome adicionado com sucesso ao alimento $nome');
  }

  void addTag(String tag) {
    if (tag.trim().isEmpty) {
      print('Erro ao adicionar tag ao alimento $nome');
      return;
    }

    tags.add(tag.trim());
    print('Tag adicionada com sucesso ao alimento $nome');
  }

  // Método para criar objeto a partir do Map (Firestore DocumentSnapshot.data())
  factory AlimentoNutraClass.fromMap(Map<String, dynamic> map) {
    return AlimentoNutraClass(
      id: map['id'],
      profileImage: map['profileImage'],
      imagensComplementares: map['imagensComplementares'],
      nome: map['nome'] ?? '',
      nomesPopulares: List<String>.from(map['nomesPopulares'] ?? []),
      formato: map['formato'] ?? '',
      sentidosPercebidos: SentidosPercebidosCarac.fromMap(
          Map<String, dynamic>.from(map['sentidosPercebidos'] ?? {})),
      tipo: map['tipo'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      valoresNutricionais: map['valoresNutricionais'], // já DocumentReference
      informacoesUso: map['informacoesUso'], // DocumentReference
      grupoAlimentar: map['grupoAlimentar'] ?? '',
      combinacoes:
          List<DocumentReference>.from(map['combinacoes'] ?? <DocumentReference>[]),
      recomendacaoEtaria: map['recomendacaoEtaria'] ?? 0,
    );
  }

  // Método para converter objeto para Map (para salvar Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileImage': profileImage,
      'imagensComplementares': imagensComplementares,
      'nome': nome,
      'nomesPopulares': nomesPopulares,
      'formato': formato,
      'sentidosPercebidos': sentidosPercebidos.toMap(),
      'tipo': tipo,
      'tags': tags,
      'valoresNutricionais': valoresNutricionais,
      'informacoesUso': informacoesUso,
      'grupoAlimentar': grupoAlimentar,
      'combinacoes': combinacoes,
      'recomendacaoEtaria': recomendacaoEtaria,
    };
  }
}

class SentidosPercebidosCarac {
  final List<String> cor;
  final List<String> odor;
  final List<String> paladar;
  final List<String> textura;
  final String som;

  SentidosPercebidosCarac({
    required this.cor,
    required this.odor,
    required this.paladar,
    required this.textura,
    required this.som,
  });

  factory SentidosPercebidosCarac.fromMap(Map<String, dynamic> map) {
    return SentidosPercebidosCarac(
      cor: List<String>.from(map['cor'] ?? []),
      odor: List<String>.from(map['odor'] ?? []),
      paladar: List<String>.from(map['paladar'] ?? []),
      textura: List<String>.from(map['textura'] ?? []),
      som: map['som'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cor': cor,
      'odor': odor,
      'paladar': paladar,
      'textura': textura,
      'som': som,
    };
  }
}
