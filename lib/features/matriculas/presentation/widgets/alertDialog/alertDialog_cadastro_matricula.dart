import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/alunoNotifier.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/providers/button_save_matricula_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/buttons/elevatedButton_salvar_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/modalidades_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

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
  String? alunoNome;

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
    final alunosAsync = ref.watch(alunoNotifierProvider);
    final modalidadesAsync = ref.watch(listModalidadeProvider);
    return AlertDialog(
      title: Text(
        'Cadastro de matricula',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
      content: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.sizeOf(context).width * 0.33,
          decoration: BoxDecoration(
            color: Colors.white,
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: DropdownSearch<String>(
                            dropdownBuilder: (context, selectedItem) {
                              return Container(
                                padding: EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            97, 97, 97, 1))),
                                child: ListTile(
                                  leading: Text(
                                      selectedItem ?? "Selecione o aluno",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey[700])),
                                  trailing: Icon(Icons.arrow_drop_down),
                                ),
                              );
                            },
                            popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        hintText: 'Pesquise o nome do aluno...',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[700]),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))))),
                            mode: Mode.custom,
                            items: (filter, loadProps) =>
                                alunos.map((e) => e.nome).toList(),
                            filterFn: (item, filter) => item
                                .toLowerCase()
                                .contains(filter.toLowerCase()),
                            onChanged: (value) {
                              debugPrint("Aluno selecionado: $value");
                              setState(() {
                                alunoSelecionado = alunos
                                    .firstWhere(
                                        (element) => element.nome == value)
                                    .id!;
                                debugPrint(
                                    'id do aluno: ${alunoSelecionado.toString()}');
                              });
                              //  alunoNome = value;
                            },
                          ),
                        ),
                        /* TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
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
                          padding: EdgeInsets.all(5),
                          height: 180, // Altura fixa para a lista
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListView.builder(
                            itemCount: filteredAlunos.length,
                            itemBuilder: (context, index) {
                              final aluno = filteredAlunos[index];
                              return ListTile(
                                minTileHeight: 1,
                                title: Text(
                                  aluno.nome!,
                                  style: TextStyle(fontSize: 14),
                                ),
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
                        ),*/
                        /*if (alunoSelecionado != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'ALUNO SELECIONADO: ${alunos.firstWhere((a) => a.id == alunoSelecionado).nome}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                            ),
                          ),*/
                      ],
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text(err.toString()),
                ),
                const SizedBox(height: 16),
                //UI
                modalidadesAsync.when(
                  data: (modalidades) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: modalidades.map((modalidade) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[300]),
                            child: CheckboxListTile(
                              title: Text(
                                modalidade.nome!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700]),
                              ),
                              value: modalidadesSelecionadas
                                  .contains(modalidade.id),
                              onChanged: (bool? selected) {
                                setState(() {
                                  if (selected == true) {
                                    modalidadesSelecionadas.add(modalidade.id!);
                                  } else {
                                    modalidadesSelecionadas
                                        .remove(modalidade.id);
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text(err.toString()),
                ),
                SizedBox(height: 30),
                // Botão de Cadastro
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              alunosAsync.value?.clear();
            },
            child: Text('Cancelar')),
        ElevatedbuttonSalvarMatricula(
            alunoSelecionado: alunoSelecionado,
            modalidadesSelecionadas: modalidadesSelecionadas),
      ],
    );
  }
}
