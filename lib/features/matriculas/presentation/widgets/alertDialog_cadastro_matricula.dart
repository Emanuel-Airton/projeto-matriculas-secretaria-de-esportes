import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/providers/matricula_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/matricula_modalidade_notifier.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/modalidades_provider.dart';

class AlertdialogCadastroMatricula extends ConsumerStatefulWidget {
  const AlertdialogCadastroMatricula({super.key});

  @override
  ConsumerState<AlertdialogCadastroMatricula> createState() =>
      _AlertdialogCadastroMatriculaState();
}

class _AlertdialogCadastroMatriculaState
    extends ConsumerState<AlertdialogCadastroMatricula> {
  final _key = GlobalKey<FormState>();
  int? alunoSelecionado;
  int? projetoSelecionado;
  List<int> modalidadesSelecionadas = [];
  TextEditingController searchController = TextEditingController();
  List<AlunoModel> filteredAlunos = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alunosAsync = ref.watch(alunoListProvider);
    final modalidadesAsync = ref.watch(listModalidadeProvider);

    return AlertDialog(
      content: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.sizeOf(context).width * 0.35,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo de pesquisa para alunos
                alunosAsync.when(
                  data: (alunos) {
                    if (filteredAlunos.isEmpty && alunos.isNotEmpty) {
                      filteredAlunos = alunos;
                    }

                    return Column(
                      children: [
                        TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: 'Pesquisar aluno',
                            suffixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredAlunos = alunos
                                  .where((aluno) => aluno.nome!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 200, // Altura fixa para a lista
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListView.builder(
                            itemCount: filteredAlunos.length,
                            itemBuilder: (context, index) {
                              final aluno = filteredAlunos[index];
                              return ListTile(
                                title: Text(aluno.nome!),
                                onTap: () {
                                  setState(() {
                                    alunoSelecionado = aluno.id;
                                    searchController.text = aluno.nome!;
                                  });
                                },
                                selected: alunoSelecionado == aluno.id,
                                selectedTileColor: Colors.blue.withOpacity(0.1),
                              );
                            },
                          ),
                        ),
                        if (alunoSelecionado != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Aluno selecionado: ${alunos.firstWhere((a) => a.id == alunoSelecionado).nome}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Erro: $err'),
                ),
                const SizedBox(height: 16),

                // Restante do seu código...
                modalidadesAsync.when(
                  data: (modalidades) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: modalidades.map((modalidade) {
                        return CheckboxListTile(
                          title: Text(modalidade.nome!),
                          value:
                              modalidadesSelecionadas.contains(modalidade.id),
                          onChanged: (bool? selected) {
                            setState(() {
                              if (selected == true) {
                                modalidadesSelecionadas.add(modalidade.id!);
                              } else {
                                modalidadesSelecionadas.remove(modalidade.id);
                              }
                            });
                          },
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Erro: $err'),
                ),
                SizedBox(height: 30),
                // Botão de Cadastro
                ElevatedButton(
                  onPressed: () async {
                    if (alunoSelecionado != null &&
                        modalidadesSelecionadas.isNotEmpty) {
                      try {
                        await ref
                            .read(matriculaUseCaseProvider)
                            .cadastrarMatriculaComModalidades(
                              alunoSelecionado!,
                              modalidadesSelecionadas,
                            );
                        ref.read(selectedModalidadeIdProvider.notifier).state =
                            null;
                        await ref
                            .read(matriculaModalidade.notifier)
                            .buscarMatriculasModalidade();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(
                          child: Text('Matricula realizada com sucesso'),
                        )));
                        Navigator.pop(context);
                      } catch (erro) {
                        debugPrint('Erro: $erro');

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(
                          child: Text(
                              'O aluno já está matriculado nessa modalidade'),
                        )));
                      }
                    }
                  },
                  child: const Text('Salvar Matrícula de modalidade'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
