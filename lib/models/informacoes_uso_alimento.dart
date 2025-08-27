class InformacoesUsoAlimento {
  final List<String> indicacoes;
  final List<String> contraIndicacoes;
  final List<String> metodosPreparo;
  final List<String> propriedadesFuncionais;

  InformacoesUsoAlimento({
    required this.indicacoes,
    required this.contraIndicacoes,
    required this.metodosPreparo,
    required this.propriedadesFuncionais,
  });

  factory InformacoesUsoAlimento.fromMap(Map<String, dynamic> map) => InformacoesUsoAlimento(
    indicacoes: List<String>.from(map['indicacoes'] ?? []),
    contraIndicacoes: List<String>.from(map['contraIndicacoes'] ?? []),
    metodosPreparo: List<String>.from(map['metodosPreparo'] ?? []),
    propriedadesFuncionais: List<String>.from(map['propriedadesFuncionais'] ?? []),
  );

  Map<String, dynamic> toMap() => {
    'indicacoes': indicacoes,
    'contraIndicacoes': contraIndicacoes,
    'metodosPreparo': metodosPreparo,
    'propriedadesFuncionais': propriedadesFuncionais,
  };
}
