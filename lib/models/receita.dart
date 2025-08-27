import 'package:cloud_firestore/cloud_firestore.dart';

class Receita {
  final String? id;
  final String? profileImage;
  final List<String>? imagensComplementares;
  final String nome;
  final DocumentReference? usuario;
  final String nomeUsuario;
  final int dificuldade;
  final String formato;
  final String tipoRefeicao;
  final int faixaEtariaRecomendada;
  final String categoriaAlimentar;
  final List<String> metodoPreparo;
  final int tempoEstimado;
  final SentidosPercebidosCarac sentidosPercebidos;
  final int rendimento;
  final int favoritos;
  final double rate;
  final List<String> indicacoes;
  final List<String> observacoes;
  final List<String> alergenosPresentes;
  final List<DocumentReference>? sugestoes;
  final List<String> tags;
  final List<String> ingredientes;
  final List<String> sazonalidade;
  final List<SecaoModoPreparo> modoPreparo;
  final List<DocumentReference>? utensilios;
  final int nFavoritos;

  Receita({
    this.id,
    this.profileImage,
    this.imagensComplementares,
    required this.nome,
    required this.usuario,
    required this.nomeUsuario,
    required this.dificuldade,
    required this.formato,
    required this.tipoRefeicao,
    required this.faixaEtariaRecomendada,
    required this.categoriaAlimentar,
    required this.metodoPreparo,
    required this.tempoEstimado,
    required this.sentidosPercebidos,
    required this.rendimento,
    required this.favoritos,
    required this.rate,
    required this.indicacoes,
    required this.observacoes,
    required this.alergenosPresentes,
    required this.sugestoes,
    required this.tags,
    required this.ingredientes,
    required this.sazonalidade,
    required this.modoPreparo,
    this.utensilios,
    required this.nFavoritos,
  });

  factory Receita.fromDocument(Map<String, dynamic> data, String id) {
    return Receita(
      id: id,
      profileImage: data['profileImage'] as String?,
      imagensComplementares: (data['imagensComplementares'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),

      nome: data['nome'] ?? '',

      usuario: data['usuario'] == null
          ? null
          : (data['usuario'] is DocumentReference
              ? data['usuario']
              : FirebaseFirestore.instance.doc(data['usuario'])),

      nomeUsuario: data['nomeUsuario'] ?? '',

      dificuldade: int.tryParse(data['dificuldade']?.toString() ?? '') ?? 1,
      formato: data['formato'] ?? '',
      tipoRefeicao: data['tipoRefeicao'] ?? '',
      faixaEtariaRecomendada:
          int.tryParse(data['faixaEtariaRecomendada']?.toString() ?? '') ?? 0,
      categoriaAlimentar: data['categoriaAlimentar'] ?? '',
      metodoPreparo: campoSeguro(data['metodoPreparo']),
      tempoEstimado:
          int.tryParse(data['tempoEstimado']?.toString() ?? '') ?? 0,

      sentidosPercebidos: data['sentidosPercebidos'] != null
          ? SentidosPercebidosCarac.fromMap(data['sentidosPercebidos'])
          : SentidosPercebidosCarac(
              cor: [],
              odor: [],
              paladar: [],
              textura: [],
              som: '',
            ),

      rendimento: int.tryParse(data['rendimento']?.toString() ?? '') ?? 0,
      favoritos: int.tryParse(data['curtidas']?.toString() ?? '') ?? 0,
      rate: (data['rate'] as num?)?.toDouble() ?? 0.0,

      sugestoes: (data['sugestoes'] as List<dynamic>?)
              ?.map((e) => e as DocumentReference)
              .toList() ??
          [],

      indicacoes: campoSeguro(data['indicacoes']),
      observacoes: campoSeguro(data['observacoes']),
      alergenosPresentes: campoSeguro(data['alergenosPresentes']),
      tags: campoSeguro(data['tags']),
      ingredientes: campoSeguro(data['ingredientes']),
      sazonalidade: campoSeguro(data['sazonalidade']),

      modoPreparo: (data['modoPreparo'] as List<dynamic>?)
              ?.map((item) => SecaoModoPreparo.fromMap(item))
              .toList() ??
          [],

      utensilios: (data['utensilios'] as List<dynamic>?)
              ?.map((e) => e as DocumentReference)
              .toList(),

      nFavoritos: int.tryParse(data['nFavoritos']?.toString() ?? '') ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'imagensComplementares': imagensComplementares,
      'nome': nome,
      'usuario': usuario,
      'nomeUsuario': nomeUsuario,
      'dificuldade': dificuldade,
      'formato': formato,
      'tipoRefeicao': tipoRefeicao,
      'faixaEtariaRecomendada': faixaEtariaRecomendada,
      'categoriaAlimentar': categoriaAlimentar,
      'metodoPreparo': metodoPreparo,
      'tempoEstimado': tempoEstimado,
      'sentidosPercebidos': {
        'cor': sentidosPercebidos.cor,
        'odor': sentidosPercebidos.odor,
        'paladar': sentidosPercebidos.paladar,
        'textura': sentidosPercebidos.textura,
        'som': sentidosPercebidos.som,
      },
      'rendimento': rendimento,
      'curtidas': favoritos,
      'rate': rate,
      'indicacoes': indicacoes,
      'observacoes': observacoes,
      'alergenosPresentes': alergenosPresentes,
      'sugestoes': sugestoes,
      'tags': tags,
      'ingredientes': ingredientes,
      'sazonalidade': sazonalidade,
      'modoPreparo': modoPreparo.map((secao) => secao.toMap()).toList(),
      'utensilios': utensilios,
      'nFavoritos': nFavoritos,
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
      cor: campoSeguro(map['cor']),
      odor: campoSeguro(map['odor']),
      paladar: campoSeguro(map['paladar']),
      textura: campoSeguro(map['textura']),
      som: map['som'] ?? '',
    );
  }
}

class Medida {
  final double medidaValor;
  final String medidaCateg;

  Medida({required this.medidaValor, required this.medidaCateg});

  factory Medida.fromMap(Map<String, dynamic> map) {
    return Medida(
      medidaValor: (map['medidaValor'] ?? 0).toDouble(),
      medidaCateg: map['medidaCateg'] ?? '',
    );
  }
}

class MedidaReceita {
  final Medida medida;
  final DocumentReference ingredienteId;
  final String ingredienteNome;
  final String modo;

  MedidaReceita({
    required this.medida,
    required this.ingredienteId,
    required this.ingredienteNome,
    required this.modo,
  });

  factory MedidaReceita.fromMap(Map<String, dynamic> map) {
    return MedidaReceita(
      medida: Medida.fromMap(map['medida']),
      ingredienteId: map['ingredienteId'],
      ingredienteNome: map['ingredienteNome'] ?? '',
      modo: map['modo'] ?? '',
    );
  }
}

class SecaoModoPreparo {
  final String nome;
  final int tempo;
  final List<String> passos;
  final String? imagem;
  final List<MedidaReceita> medidaIngredienteList;

  SecaoModoPreparo({
    required this.nome,
    required this.tempo,
    required this.passos,
    this.imagem,
    required this.medidaIngredienteList,
  });

  factory SecaoModoPreparo.fromMap(Map<String, dynamic> map) {
    return SecaoModoPreparo(
      nome: map['nome'] ?? '',
      tempo: map['tempo'] ?? 0,
      passos: campoSeguro(map['passos']),
      imagem: map['imagem'],
      medidaIngredienteList: (map['medidaIngredienteList'] as List<dynamic>? ?? [])
          .map((item) => MedidaReceita.fromMap(item))
          .toList(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'titulo': nome,
      'passos': passos,
    };
  }
}

List<String> campoSeguro(dynamic valor) {
  if (valor is Iterable) {
    return List<String>.from(valor);
  }
  return [];
}

