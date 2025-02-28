import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/container_form_aluno.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/dialog_cadastro_aluno.dart';

class AlunosScreen extends ConsumerStatefulWidget {
  const AlunosScreen({super.key});

  @override
  ConsumerState<AlunosScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<AlunosScreen> {
  final Map<int, bool> _expandedState = {};

  @override
  Widget build(BuildContext context) {
    final alunosAsync = ref.watch(alunoListProviderListen);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DialogCadastroAluno();
              },
            );
          },
          label: Text('Adicionar aluno')),
      body: Row(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.6,
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lista de alunos',
                  style: TextStyle(fontSize: 20),
                ),
                Flexible(
                  child: alunosAsync.when(
                    data: (alunos) {
                      return ListView.builder(
                        itemCount: alunos.length,
                        itemBuilder: (context, index) {
                          final isExpanded = _expandedState[index] ?? false;
                          final aluno = alunos[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              height: isExpanded
                                  ? MediaQuery.sizeOf(context).height * 0.7
                                  : MediaQuery.sizeOf(context).height * 0.08,
                              duration: const Duration(milliseconds: 200),
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(2, 3))
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title:
                                          Text('Aluno: ${aluno.nome} ' ?? ''),
                                      subtitle: Text(aluno.telefone ?? ''),
                                      trailing: Tooltip(
                                        message: 'Visualizar mais informações',
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _expandedState[index] =
                                                    !isExpanded;
                                              });
                                            },
                                            icon: Icon(isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down)),
                                      ),
                                    ),
                                    if (isExpanded) ...[
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              padding: EdgeInsets.all(15),
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.62,
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              //padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: ContainerFormAluno(
                                                  alunoModel: aluno)))
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Erro: $err')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
