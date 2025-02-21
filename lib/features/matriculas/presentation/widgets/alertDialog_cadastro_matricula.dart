import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import '../../../modalidades/presentation/providers/modalidades_provider.dart';
import '../../../projetos/presentation/providers/projetos_provider.dart';
import '../../data/models/matricula_model.dart';
import '../providers/matricula_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final alunosAsync = ref.read(alunoListProvider);
    final projetosAsync = ref.watch(listProjetosProvider);
    final modalidadesAsync = ref.watch(listModalidadeProvider);

    return AlertDialog(
      content: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.sizeOf(context).width * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown de Alunos
                alunosAsync.when(
                  data: (alunos) {
                    return DropdownButtonFormField<int>(
                      value: alunoSelecionado,
                      hint: const Text('Selecione um aluno'),
                      onChanged: (value) =>
                          setState(() => alunoSelecionado = value),
                      items: alunos.map((aluno) {
                        return DropdownMenuItem<int>(
                          value: aluno.id,
                          child: Text(aluno.nome!),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Erro: $err'),
                ),
                const SizedBox(height: 16),

                // Dropdown de Projetos
                projetosAsync.when(
                  data: (projetos) {
                    return DropdownButtonFormField<int>(
                      value: projetoSelecionado,
                      hint: const Text('Selecione um projeto'),
                      onChanged: (value) =>
                          setState(() => projetoSelecionado = value),
                      items: projetos.map((projeto) {
                        return DropdownMenuItem<int>(
                          value: projeto.id,
                          child: Text(projeto.nome!),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Erro: $err'),
                ),
                const SizedBox(height: 16),

                // Checkbox das Modalidades
                modalidadesAsync.when(
                  data: (modalidades) {
                    // debugPrint('modalidasde: $modalidades');
                    return Column(
                      children: modalidades.map((modalidade) {
                        debugPrint('nome ${modalidade.nome!}');
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

                // Botão de Cadastro
                ElevatedButton(
                  onPressed: () async {
                    if (alunoSelecionado != null &&
                        projetoSelecionado != null &&
                        modalidadesSelecionadas.isNotEmpty) {
                      try {
                        MatriculaModel matriculaModel =
                            MatriculaModel.cadastrarDados(
                                idAluno: alunoSelecionado,
                                idProjeto: projetoSelecionado,
                                dataMatricula: DateTime.now());
                        await ref
                            .read(matriculaUseCaseProvider)
                            .cadastrarMatriculaComModalidades(
                              matriculaModel,
                              modalidadesSelecionadas,
                            );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(
                          child: Text('Matricula realizada dom sucesso'),
                        )));
                        Navigator.pop(context);
                      } catch (erro) {
                        debugPrint('Erro: $erro');
                      }
                    }
                  },
                  child: const Text('Salvar Matrícula'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
