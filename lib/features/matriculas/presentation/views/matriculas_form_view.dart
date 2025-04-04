import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/alertDialog_cadastro_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/alertDialog_delete_matricula_modalidade.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/container_info_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/matricula_modalidade_notifier.dart';
import '../../../modalidades/presentation/providers/modalidades_provider.dart';
import '../../../modalidades/presentation/widgets/row_containers_select_modalidade.dart';

class MatriculaFormView extends ConsumerStatefulWidget {
  const MatriculaFormView({super.key});

  @override
  ConsumerState<MatriculaFormView> createState() => _MatriculaFormViewState();
}

class _MatriculaFormViewState extends ConsumerState<MatriculaFormView> {
  Map<int, bool> map = {};

  @override
  Widget build(BuildContext context) {
    final matriculasModalidades = ref.watch(matriculaModalidade);
    final modalidade = ref.watch(buscarModalidade);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Matriculas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      /*   floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertdialogCadastroMatricula();
            },
          );
        },
        label: Text('Nova matricula'),
      ),*/
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seletor de Modalidade
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: RowContainersSelectModalidade(),
            ),

            const SizedBox(height: 15),

            // Modalidade Selecionada
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Text('Modalidade selecionada:'),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: modalidade.when(
                        data: (data) {
                          return Center(
                            child: Text(
                              data != null ? data.nome! : 'Todas modalidades',
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return Text('Erro ao carregar');
                        },
                        loading: () {
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(
                            MediaQuery.sizeOf(context).width * 0.12,
                            MediaQuery.sizeOf(context).height * 0.045))),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertdialogCadastroMatricula();
                        },
                      );
                    },
                    label: Text('Nova matricula'))
              ],
            ),

            const SizedBox(height: 15),

            // Lista de Matrículas
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: matriculasModalidades.length,
                itemBuilder: (context, index) {
                  final isExpanded = map[index] ?? false;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'N° da matricula: ${matriculasModalidades[index].id.toString()}',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Aluno: ${matriculasModalidades[index].aluno!.nome.toString()}',
                                ),
                                subtitle: Text(
                                  'Modalidade: ${matriculasModalidades[index].modalidadeNome.toString()}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Tooltip(
                                      message: 'Excluir matricula',
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertdialogDeleteMatriculaModalidade(
                                                alunoId:
                                                    matriculasModalidades[index]
                                                        .id,
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Tooltip(
                                      message: 'Visualizar mais informações',
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            map[index] = !isExpanded;
                                          });
                                        },
                                        icon: Icon(
                                          !isExpanded
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_up,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isExpanded) ...[
                                ContainerInfoMatricula(
                                  matriculasModalidadesModel:
                                      matriculasModalidades[index],
                                ),
                              ],
                            ],
                          ),
                        ],
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
