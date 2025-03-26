import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/alunoNotifier.dart';
import '../providers/aluno_provider.dart';

class AlertdialogDeleteAluno extends ConsumerStatefulWidget {
  final int alunoId;
  final String alunoNome;
  const AlertdialogDeleteAluno(
      {super.key, required this.alunoId, required this.alunoNome});

  @override
  ConsumerState<AlertdialogDeleteAluno> createState() =>
      _AlertdialogDeleteAlunoState();
}

class _AlertdialogDeleteAlunoState
    extends ConsumerState<AlertdialogDeleteAluno> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deseja excluir esse aluno?'),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.1,
        child: Center(
          child: Text(
              'O(a) aluno(a) ${widget.alunoNome} será removido(a) de forma permanente!'),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
            child: Text('cancelar')),
        TextButton(
          onPressed: () {
            try {
              /* ref.read(alunoUseCaseProvider).deletarAluno(widget.alunoId);
              debugPrint('Aluno deletado com sucesso');*/
              ref
                  .read(alunoNotifierProvider.notifier)
                  .deletarAluno(widget.alunoId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  content: Center(
                child: Text('Registro de aluno excluido com sucesso'),
              )));
            } catch (erro) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  content: Center(
                child: Text('Erro ao excluir aluno'),
              )));
            }
            Navigator.pop(context);
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary)),
          child: Text('Excluir', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
