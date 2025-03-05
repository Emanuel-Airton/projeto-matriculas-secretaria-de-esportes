import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/alertDialog_cadastro_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/container_info_matricula.dart';
import '../../../modalidades/presentation/providers/modalidades_provider.dart';
import '../../../modalidades/presentation/widgets/row_containers_select_modalidade.dart';

class MatriculaFormView extends ConsumerStatefulWidget {
  const MatriculaFormView({super.key});

  @override
  ConsumerState<MatriculaFormView> createState() => _MatriculaFormViewState();
}

class _MatriculaFormViewState extends ConsumerState<MatriculaFormView> {
  // bool isExpanded = false;
  Map<int, bool> map = {};

  @override
  Widget build(BuildContext context) {
    final matriculasModalidades = ref.watch(listMatriculaModalidadeProvider);
    final modalidade = ref.watch(buscarModalidade);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Matrículas'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertdialogCadastroMatricula();
                });
          },
          label: Text('Nova matricula')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height *
                  0.15, // Defina uma altura fixa
              child: RowContainersSelectModalidade(),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.inversePrimary),
                    child: Text('Modalidade selecionada:')),
                SizedBox(width: 10),
                Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.inversePrimary),
                    child: modalidade.when(
                      data: (data) {
                        debugPrint(data.toString());
                        return Center(
                          child: Text(data != null ? data.nome! : 'todas'),
                        );
                      },
                      error: (error, stackTrace) {
                        return null;
                      },
                      loading: () {
                        return null;
                      },
                    )),
              ],
            ),
            // Dropdown de Projetos
            matriculasModalidades.when(
              data: (matriculas) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: matriculas.length,
                    itemBuilder: (context, index) {
                      final isExpanded = map[index] ?? false;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: !isExpanded
                              ? MediaQuery.sizeOf(context).height * 0.12
                              : MediaQuery.sizeOf(context).height * 0.5,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(2, 3))
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'N° da matricula: ${matriculas[index].id.toString()}'),
                                  //   Text('Data da matricula: $data')
                                ],
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        'Aluno: ${matriculas[index].aluno!.nome.toString()}'),
                                    subtitle: Text(
                                        'Modalidade: ${matriculas[index].modalidadeNome.toString()}'),
                                    trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            map[index] = !isExpanded;
                                          });
                                        },
                                        icon: Icon(!isExpanded
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up)),
                                  ),
                                  if (isExpanded) ...[
                                    ContainerInfoMatricula(
                                        matriculasModalidadesModel:
                                            matriculas[index])
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => Center(child: const CircularProgressIndicator()),
              error: (err, stack) => Text('Erro: $err'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
