import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Substitua pelos seus arquivos corretos:
import '../../widgets/widgets.dart'; // ← Certifique-se de que contém ReceitaRatedWidget, NutraAppBar etc.
import '../../models/receita.dart'; // ← Deve conter o model Receita com `fromDocument`
import '../../constants/constants.dart'; // ← Deve conter suas constantes como `CaracteristicasConstants`
import '../../functions/functions.dart';

class ReceitasSearchPage extends StatefulWidget {
  const ReceitasSearchPage({super.key});

  @override
  State<ReceitasSearchPage> createState() => _ReceitasSearchPageState();
}

class _ReceitasSearchPageState extends State<ReceitasSearchPage> {
  List<Receita> _receitas = [];
  String? _criterioOrdenacao;
  String _termoBusca = '';

  List<String> _formatosSelecionados = [];
 List<String> _tiposRefeicaoSelecionados = [];
 List<String> _categoriasSelecionadas = [];


  Map<String, List<String>> _filtrosAvancados = {};
  
  String? _formatoSelecionado;
  String? _tipoRefeicaoSelecionado;
  String? _categoriaSelecionada;

  List<String> meusTiposSelecionados = [];

  void _ordenarReceitas() {
    if (_criterioOrdenacao == null) return;

    setState(() {
      _receitas.sort((a, b) {
        switch (_criterioOrdenacao) {
          case 'rating':
            return b.rate.compareTo(a.rate);
          case 'tempo':
            return a.tempoEstimado.compareTo(b.tempoEstimado);
          case 'dificuldade':
            return a.dificuldade.compareTo(b.dificuldade);
          case 'faixaEtaria':
            return a.faixaEtariaRecomendada.compareTo(b.faixaEtariaRecomendada);
          case 'rendimento':
            return b.rendimento.compareTo(a.rendimento);
          case 'favoritos':
            return b.favoritos.compareTo(a.favoritos);
          default:
            return 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NutraAppBar(
        onAction: () {},
        actionIcon: Icons.help_outline_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Busca + Botão
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _termoBusca = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar receita...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => FocusScope.of(context).unfocus(),
                  child: const Icon(Icons.search),
                )
              ],
            ),

            const SizedBox(height: 10),

            // Ordenação + Filtros
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //Ordenação
                  IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () async {
                      final resultado = await showModalBottomSheet<String>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const OrdenacaoRceitaModal(), // ← Remova `onSelecionar`
                      );

                      if (!mounted) return;

                      if (resultado != null) {
                        setState(() {
                          _criterioOrdenacao = resultado;
                          _ordenarReceitas();
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 10),

                  //Filtro Formato
                  SizedBox(
                    width: 200,
                    child: TipoDropdownWidget(
                      campoNome: 'Formato',
                      options: CaracteristicasConstants.formatos.map((e) => e["nome"]!).toList(),
                      selectedValues: _formatosSelecionados,
                      onChanged: (novosSelecionados) {
                        setState(() {
                          _formatosSelecionados = novosSelecionados;
                          _filtrosAvancados['formato'] = novosSelecionados;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Filtro Tipo de Refeição
                  SizedBox(
                    width: 200,
                    child: TipoDropdownWidget(
                      campoNome: 'Tipo de Refeição',
                      options: PropriedadesAlimentaresConstants.tiposRefeicao.map((e) => e["nome"]!).toList(),
                      selectedValues: _tiposRefeicaoSelecionados,
                      onChanged: (novosSelecionados) {
                        setState(() {
                          _tiposRefeicaoSelecionados = novosSelecionados;
                          _filtrosAvancados['tipoRefeicao'] = novosSelecionados;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Filtro Categoria
                  SizedBox(
                    width: 200,
                    child: TipoDropdownWidget(
                      campoNome: 'Categoria',
                      options: PropriedadesAlimentaresConstants.categoriasAlimentares.map((e) => e.nome).toList(),
                      selectedValues: _categoriasSelecionadas,
                      onChanged: (novosSelecionados) {
                        setState(() {
                          _categoriasSelecionadas = novosSelecionados;
                          _filtrosAvancados['categoriaAlimentar'] = novosSelecionados;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              icon: const Icon(Icons.filter_alt),
              label: const Text('Busca Avançada'),
              onPressed: () {
                final filtrosCompletos = Map<String, List<String>>.from(_filtrosAvancados);

                if (_formatoSelecionado != null) {
                  filtrosCompletos.update('formato', (list) => [...list, _formatoSelecionado!],
                      ifAbsent: () => [_formatoSelecionado!]);
                }
                if (_tipoRefeicaoSelecionado != null) {
                  filtrosCompletos.update('tipoRefeicao', (list) => [...list, _tipoRefeicaoSelecionado!],
                      ifAbsent: () => [_tipoRefeicaoSelecionado!]);
                }
                if (_categoriaSelecionada != null) {
                  filtrosCompletos.update('categoriaAlimentar', (list) => [...list, _categoriaSelecionada!],
                      ifAbsent: () => [_categoriaSelecionada!]);
                }

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => BuscaAvancadaModal(
                    filtrosDisponiveis: {
                      'dificuldade': InformacoesConstants.dificuldades,
                      'formato': CaracteristicasConstants.formatos.map((e) => e["nome"]!).toList(),
                      'tipoRefeicao': PropriedadesAlimentaresConstants.tiposRefeicao.map((e) => e["nome"]!).toList(),
                      'faixaEtaria': InformacoesConstants.faixasEtarias
                                      .map((e) => e["nome"] as String)
                                      .toList(),
                      'categoriaAlimentar': PropriedadesAlimentaresConstants.categoriasAlimentares.map((e) => e.nome).toList(),
                      'metodoPreparo': PropriedadesAlimentaresConstants.metodosPreparo,
                      'tempoEstimado': ['<10 min', '10-30 min', '>30 min'],
                      'rendimento': ['1 porção', '2 porções', '3+ porções'],
                      'sazonalidade': InformacoesConstants.sazonalidade
                                      .map((e) => e["nome"] as String)
                                      .toList(),
                      'textura': CaracteristicasConstants.textura,
                      'odor': CaracteristicasConstants.odor,
                      'som': CaracteristicasConstants.som,
                      'paladar': CaracteristicasConstants.paladar,
                      'alergenos': InformacoesConstants.alergenos.map((e) => e["nome"]!).toList(),
                    },
                    filtrosSelecionados: filtrosCompletos, // <-- AGORA ENVIAMOS OS ATUAIS
                    onAplicar: (filtros) {
                      print('Filtros selecionados: $filtros');
                      setState(() {
                        _filtrosAvancados = filtros;

                        // Atualiza os filtros simples se existirem no mapa retornado
                        _formatosSelecionados = List<String>.from(filtros['formato'] ?? []);
                        _tiposRefeicaoSelecionados = List<String>.from(filtros['tipoRefeicao'] ?? []);
                        _categoriasSelecionadas = List<String>.from(filtros['categoriaAlimentar'] ?? []);

                        // Atualiza seleção múltipla do tipo
                        meusTiposSelecionados = List<String>.from(filtros['tipo'] ?? []);

                        // Remove os filtros simples do mapa de filtros avançados (para não duplicar)
                        _filtrosAvancados.remove('formato');
                        _filtrosAvancados.remove('tipoRefeicao');
                        _filtrosAvancados.remove('categoriaAlimentar');
                      });
                    },
                  ),
                );
              },
            ),


            const SizedBox(height: 10),

            //Filtros e Limpeza
            ResumoFiltrosWidget(
              filtrosAtivos: {
                'Formato': _formatoSelecionado,
                'Tipo de Refeição': _tipoRefeicaoSelecionado,
                'Categoria': _categoriaSelecionada,
                'Ordenar por': _criterioOrdenacao,
                 ..._filtrosAvancados.map((k, v) => MapEntry(formatarTitulo(k), v.join(', '))),
              },
              onRemover: (chave) {
                setState(() {
                  switch (chave) {
                    case 'Formato':
                      _formatoSelecionado = null;
                      break;
                    case 'Tipo de Refeição':
                      _tipoRefeicaoSelecionado = null;
                      break;
                    case 'Categoria':
                      _categoriaSelecionada = null;
                      break;
                    case 'Ordenar por':
                      _criterioOrdenacao = null;
                      break;
                    default:
                      // Trata os filtros da busca avançada
                      _filtrosAvancados.removeWhere((k, v) {
                        return formatarTitulo(k) == chave;
                      });
                  }
                });
              },
              onLimparTudo: () {
                setState(() {
                  _formatoSelecionado = null;
                  _tipoRefeicaoSelecionado = null;
                  _categoriaSelecionada = null;
                  _criterioOrdenacao = null;
                  _termoBusca = '';
                  _filtrosAvancados.clear(); // ← ISSO AQUI!
                });
              },
            ),
            //Filtros e Limpeza

            // Lista de receitas
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('receita').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar receitas.'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final receitasFiltradas = snapshot.data!.docs.map((doc) {
                    final receita = Receita.fromDocument(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    );
                    return receita;
                  }).where((receita) {
                    final nomeOk = receita.nome.toLowerCase().contains(_termoBusca.toLowerCase());
                    final formatoOk = _formatoSelecionado == null || receita.formato == _formatoSelecionado;
                    final tipoOk = _tipoRefeicaoSelecionado == null || receita.tipoRefeicao == _tipoRefeicaoSelecionado;
                    final categoriaOk = _categoriaSelecionada == null || receita.categoriaAlimentar == _categoriaSelecionada;

                    // Filtros avançados
                    bool filtrosAvancadosOk = true;
                    _filtrosAvancados.forEach((chave, valoresSelecionados) {
                      final valorReceita = receita.toMap()[chave];
                      if (valorReceita == null || !valoresSelecionados.contains(valorReceita)) {
                        filtrosAvancadosOk = false;
                      }
                    });

                    return nomeOk && formatoOk && tipoOk && categoriaOk && filtrosAvancadosOk;
                  }).toList();

                  if (_criterioOrdenacao != null) {
                    receitasFiltradas.sort((a, b) {
                      switch (_criterioOrdenacao) {
                        case 'rating':
                          return b.rate.compareTo(a.rate);
                        case 'tempo':
                          return a.tempoEstimado.compareTo(b.tempoEstimado);
                        case 'dificuldade':
                          return a.dificuldade.compareTo(b.dificuldade);
                        case 'faixaEtaria':
                          return a.faixaEtariaRecomendada.compareTo(b.faixaEtariaRecomendada);
                        case 'rendimento':
                          return b.rendimento.compareTo(a.rendimento);
                        case 'favoritos':
                          return b.favoritos.compareTo(a.favoritos);
                        default:
                          return 0;
                      }
                    });
                  }

                  if (receitasFiltradas.isEmpty) {
                    return const Center(child: Text('Nenhuma receita encontrada.'));
                  }

                  return SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 15,
                        runSpacing: 15,
                        children: receitasFiltradas.map((receita) {
                          return SizedBox(
                            width: 175,
                            child: ReceitaRatedWidget(
                              imagePath: receita.profileImage ?? 'assets/sistema/ImagemNDisponivel.png',
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

