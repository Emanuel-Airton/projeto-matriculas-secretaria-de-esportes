import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/matricula_modalidade_notifier.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class AlertdialogDeleteMatriculaModalidade extends ConsumerStatefulWidget {
  final int? alunoId;
  final int? modalidadeID;
  const AlertdialogDeleteMatriculaModalidade(
      {super.key, required this.alunoId, this.modalidadeID});

  @override
  ConsumerState<AlertdialogDeleteMatriculaModalidade> createState() =>
      _AlertdialogDeleteMatriculaModalidadeState();
}

class _AlertdialogDeleteMatriculaModalidadeState
    extends ConsumerState<AlertdialogDeleteMatriculaModalidade> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deseja excluir essa matricula?'),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.1,
        child: Center(
          child:
              Text('A matricula do aluno será removida de forma permanente!'),
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
            final Result result = await ref
                .read(matriculaModalidade.notifier)
                .deletarMatriculaModalidade(widget.alunoId!,
                    idModalidade: widget.modalidadeID);
            final msg = result is Ok
                ? 'Matricula excluida com sucesso'
                : 'Erro ao excluir matricula!';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(
              child: Text(msg),
            )));
            if (result is Ok) Navigator.pop(context);
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
