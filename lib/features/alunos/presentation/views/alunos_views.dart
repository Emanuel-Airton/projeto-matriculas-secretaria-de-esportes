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
  int? totalAlunos;
  int? totalMeninos;
  int? totalMeninas;
  final Map<int, bool> _expandedState = {};

  @override
  Widget build(BuildContext context) {
    final alunosAsync = ref.watch(alunoListProviderListen);
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 15, 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
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
                        totalAlunos = alunos.length;
                        List list = [];
                        for (var aluno in alunos) {
                          if (aluno.sexo == 'masculino') {
                            list.add(aluno.sexo);
                            totalMeninos = list.length;
                          } else if (aluno.sexo == 'feminino') {
                            list.clear();
                            list.add(aluno.sexo);
                            totalMeninas = list.length;
                          }
                        }
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
                                        title: Text('${aluno.nome} ' ?? ''),
                                        subtitle: Text(aluno.telefone ?? ''),
                                        trailing: Tooltip(
                                          message:
                                              'Visualizar mais informações',
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
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.62,
                                                width:
                                                    MediaQuery.sizeOf(context)
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 10, 20),
            child: Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.sizeOf(context).width * 0.16,
              height: MediaQuery.sizeOf(context).height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                children: [
                  Image.asset('assets/images/adl10.png',
                      height: MediaQuery.sizeOf(context).height * 0.2),
                  SizedBox(height: 60),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Column(
                      children: [
                        ListTile(
                            leading: Image.asset('assets/images/student.png',
                                height:
                                    MediaQuery.sizeOf(context).height * 0.04),
                            title: Text(
                                'Total de alunos  ${totalAlunos.toString()}')),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Column(
                      children: [
                        ListTile(
                            leading: Image.asset('assets/images/masculino.png',
                                height:
                                    MediaQuery.sizeOf(context).height * 0.04),
                            title: Text(
                                'Total de meninos  ${totalMeninos.toString()}')),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Column(
                      children: [
                        ListTile(
                            leading: Image.asset('assets/images/femenino.png',
                                height:
                                    MediaQuery.sizeOf(context).height * 0.04),
                            title: Text(
                                'Total de meninas  ${totalMeninas.toString()}')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
