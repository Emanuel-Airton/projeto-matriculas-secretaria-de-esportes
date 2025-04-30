import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/container_info_alunos.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/dialog_cadastro_aluno.dart';
import '../../data/models/aluno_model.dart';
import '../../data/repositories/aluno_repository.dart';
import '../providers/alunoNotifier.dart';
import '../widgets/animatedContainer.dart';

class AlunosScreen extends ConsumerStatefulWidget {
  const AlunosScreen({super.key});

  @override
  ConsumerState<AlunosScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<AlunosScreen> {
  int totalAlunos = 0;
  int totalMeninos = 0;
  int totalMeninas = 0;
  TextEditingController controller = TextEditingController();
  AsyncValue<List<AlunoModel?>>? alunosAsync;
  AlunoRepository alunoRepository = AlunoRepository();
  String? teste;

  @override
  Widget build(BuildContext context) {
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
        label: Text('Adicionar aluno'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildWideLayout(context);
          /*   if (constraints.maxWidth > 600) {
            return _buildWideLayout(context);
          } */
          /*else {
            return _buildNarrowLayout(context);
          }*/
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    final alunoNotifier = ref.read(alunoNotifierProvider.notifier);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 15, 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista de alunos',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    ref.read(nomeAlunoProvider.notifier).state =
                                        value;
                                    alunoNotifier.buscarAlunoNome(value);
                                  },
                                  controller: controller,
                                  decoration: InputDecoration(
                                    hintText: 'Pesquisar aluno por nome',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // ref.watch(nomeAluno.notifier).state = controller.text;
                                  // alunosAsync = ref.watch(alunoListProviderListen);
                                },
                                icon: Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Animatedcontainer(),
                  /* Center(
                    child: TextButton(
                      onPressed: () async {
                        final valor = ref.read(countListenable);
                        ref.read(count.notifier).state = (valor! * 2);
                        alunosAsync = ref.watch(alunoListProviderListen);
                      },
                      child: Text('Carregar mais...'),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 10, 20),
            child: ContainerInfoAlunos()),
      ],
    );
  }

/*  Widget _buildNarrowLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista de alunos',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              ref.read(nomeAlunoProvider.notifier).state =
                                  value;
                              ref
                                  .read(alunoNotifierProvider.notifier)
                                  .buscarAlunoNome(value);
                            },
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'Pesquisar aluno por nome',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // ref.watch(nomeAluno.notifier).state = controller.text;
                            // alunosAsync = ref.watch(alunoListProviderListen);
                          },
                          icon: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Animatedcontainer(),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final valor = ref.read(countListenable);
                        ref.read(count.notifier).state = (valor! * 2);
                        alunosAsync = ref.watch(alunoListProviderListen);
                      },
                      child: Text('Carregar mais...'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            /* Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/adl10.png',
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  SizedBox(height: 60),
                  containerInfoListAlunos(
                    context,
                    'assets/images/student.png',
                    'Total de alunos  ${totalAlunos.toString()}',
                  ),
                  SizedBox(height: 30),
                  containerInfoListAlunos(
                    context,
                    'assets/images/masculino.png',
                    'Total de meninos  ${totalMeninos.toString()}',
                  ),
                  SizedBox(height: 30),
                  containerInfoListAlunos(
                    context,
                    'assets/images/femenino.png',
                    'Total de meninas  ${totalMeninas.toString()}',
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }*/
}
