import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/alunoNotifier.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/buttom_delete_aluno_provider.dart';
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
          onPressed: () async {
            ref.read(buttonDeleteAlunoProvider.notifier).saveButton(() async {
              try {
                await ref
                    .read(alunoNotifierProvider.notifier)
                    .deletarAluno(widget.alunoId);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Center(
                  child: Text('Registro de aluno deletado com sucesso'),
                )));
                Navigator.pop(context);
              } catch (e) {
                debugPrint('ERRO: ${e.toString()}');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Center(
                  child: Text('Erro ao excluir registro de aluno'),
                )));
              }
            });

            //Navigator.pop(context);
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary)),
          child: ref.watch(buttonDeleteAlunoProvider).isloading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2))
              : Text('Excluir', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
