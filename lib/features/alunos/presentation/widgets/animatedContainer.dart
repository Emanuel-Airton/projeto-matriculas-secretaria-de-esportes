import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/alertDialog_delete_aluno.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/container_form_aluno.dart';
import '../providers/alunoNotifier.dart';

final expandedStateProvider = StateProvider<Map<int, bool>>((ref) => {});

class Animatedcontainer extends ConsumerWidget {
  const Animatedcontainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAlunos = ref.watch(alunoNotifierProvider);
    Future.delayed(Duration(seconds: 1)).then((value) {
      debugPrint('lista atualizada');
      ref.read(listAlunosProvider.notifier).state = listAlunos;
      //ref.read(quantidadeAlunos);
    });
    final expandedState = ref.watch(expandedStateProvider);

    if (listAlunos.isNotEmpty) {
      return Flexible(
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: listAlunos.length,
                itemBuilder: (context, index) {
                  final aluno = listAlunos[index];
                  final isExpanded = expandedState[index] ?? false;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AnimatedContainer(
                      height: isExpanded
                          ? MediaQuery.sizeOf(context).height * 0.64
                          : MediaQuery.sizeOf(context).height * 0.08,
                      duration: const Duration(milliseconds: 200),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${aluno.nome} '),
                              subtitle: Text(aluno.telefone ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Tooltip(
                                    message: 'Excluir registro do aluno',
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertdialogDeleteAluno(
                                                      alunoId: aluno.id!,
                                                      alunoNome: aluno.nome));
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        )),
                                  ),
                                  SizedBox(width: 15),
                                  Tooltip(
                                    message: 'Visualizar mais informações',
                                    child: IconButton(
                                      onPressed: () {
                                        // debugPrint(expandedState.toString());
                                        ref
                                            .read(
                                                expandedStateProvider.notifier)
                                            .state = {
                                          ...expandedState,
                                          index: !isExpanded,
                                        };
                                      },
                                      icon: Icon(isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isExpanded) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.56,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ContainerFormAluno(alunoModel: aluno),
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      );
    }
    return Center(child: Text('NENHUM ALUNO ENCONTRADO'));

    // return const Center(child: CircularProgressIndicator());
  }
}
