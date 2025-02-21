import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/providers/matricula_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/alertDialog_cadastro_matricula.dart';
import 'package:intl/intl.dart';

class MatriculaFormView extends ConsumerStatefulWidget {
  const MatriculaFormView({super.key});

  @override
  ConsumerState<MatriculaFormView> createState() => _MatriculaFormViewState();
}

class _MatriculaFormViewState extends ConsumerState<MatriculaFormView> {
  @override
  Widget build(BuildContext context) {
    final matriculasAsync = ref.watch(listMatriculaListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Matrículas')),
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
            const SizedBox(height: 16),
            // Dropdown de Projetos
            matriculasAsync.when(
              data: (matriculas) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: matriculas.length,
                    itemBuilder: (context, index) {
                      final dataFormat = DateFormat('dd/MM/yyyy');
                      String data =
                          dataFormat.format(matriculas[index].dataMatricula!);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: MediaQuery.sizeOf(context).height * 0.12,
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
                                  Text('Data da matricula: $data')
                                ],
                              ),
                              ListTile(
                                title: Text(
                                    'Aluno: ${matriculas[index].nomeAluno.toString()}'),
                                subtitle: Text(
                                    'Projeto: ${matriculas[index].nomeProjeto.toString()}'),
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
