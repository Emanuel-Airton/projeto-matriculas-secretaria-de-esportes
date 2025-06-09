import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/alertDialog_cadastro_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/alertDialog_delete_matricula_modalidade.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/container_info_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/pdf_preview_lista_matriculas.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/matricula_modalidade_notifier.dart';
import 'package:projeto_secretaria_de_esportes/shared/widgets/containers/container_search.dart';
import '../../../modalidades/presentation/providers/modalidades_provider.dart';
import '../../../modalidades/presentation/widgets/row_containers_select_modalidade.dart';

class MatriculaFormView extends ConsumerStatefulWidget {
  const MatriculaFormView({super.key});

  @override
  ConsumerState<MatriculaFormView> createState() => _MatriculaFormViewState();
}

class _MatriculaFormViewState extends ConsumerState<MatriculaFormView> {
  Map<int, bool> map = {};

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final matriculasModalidades = ref.watch(matriculaModalidade);
    final modalidade = ref.watch(buscarModalidade);
    debugPrint('id: ${modalidade.value?.id.toString()}');
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                        color: Colors.white,
                      ),
                      child: Text('Modalidade selecionada',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700])),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[700])),
                          );
                        },
                        error: (error, stackTrace) {
                          return Text('Erro ao carregar');
                        },
                        loading: () {
                          return CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                        icon: Icon(Icons.picture_as_pdf),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return PdfPreviewListaMatriculas(
                                    listMatriculasModalidade:
                                        matriculasModalidades.value ?? []);
                              });
                        },
                        label: Text('Vizualizar lista de matriculas'))
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.sizeOf(context).height * 0.74,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lista de matriculas',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(height: 15),
                    ContainerSearch(
                      controller: controller,
                      texto: 'Pesquisar matricula por aluno...',
                      function: (value) {
                        ref
                            .read(matriculaModalidade.notifier)
                            .buscarMatriculaModalidadePnomeAluno(value,
                                idModalidade: modalidade.value?.id);
                      },
                    ),
                    SizedBox(height: 15),
                    matriculasModalidades.when(
                      data: (data) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final isExpanded = map[index] ?? false;
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(2, 3))
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[200],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'N° da matricula: ${data[index].id.toString()}',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Aluno: ${data[index].aluno!.nome.toString()}',
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                            subtitle: Text(
                                              'Modalidade: ${data[index].modalidadeNome.toString()}',
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
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
                                                                data[index].id,
                                                            modalidadeID:
                                                                modalidade
                                                                    .value?.id,
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
                                                  message:
                                                      'Visualizar mais informações',
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        map[index] =
                                                            !isExpanded;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      !isExpanded
                                                          ? Icons
                                                              .keyboard_arrow_down
                                                          : Icons
                                                              .keyboard_arrow_up,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (isExpanded) ...[
                                            ContainerInfoMatricula(
                                              matriculasModalidadesModel:
                                                  data[index],
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
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(
                            child: Text(error.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)));
                      },
                      loading: () {
                        return Center(
                            child:
                                CircularProgressIndicator(color: Colors.red));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
