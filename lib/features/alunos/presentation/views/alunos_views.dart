import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/container_info_alunos.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/dialog_cadastro_aluno.dart';
import 'package:projeto_secretaria_de_esportes/shared/widgets/containers/container_search.dart';
import '../../data/models/aluno_model.dart';
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
  //AlunoRepository alunoRepository = AlunoRepository();
  String? teste;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogCadastroAluno();
            },
          );
        },
        label: Text('Adicionar aluno',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500]),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      ContainerSearch(
                        controller: controller,
                        texto: 'Pesquisar aluno por nome...',
                        function: (p0) {
                          try {
                            ref
                                .read(alunoNotifierProvider.notifier)
                                .buscarAlunoPorNome(p0);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
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
}
