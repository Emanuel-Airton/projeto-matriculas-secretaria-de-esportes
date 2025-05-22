import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/button_save_aluno_provider.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(buttonSaveAlunoProvider);

    return Column(
      children: [
        ElevatedButton(
          onPressed: state.isloading
              ? null
              : () => ref
                      .read(buttonSaveAlunoProvider.notifier)
                      .saveButton(() async {
                    return debugPrint('testando função');
                  }),
          child: state.isloading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : const Text('Salvar'),
        ),
        if (state.isSucess)
          const Text('Salvo com sucesso!',
              style: TextStyle(color: Colors.green)),
        if (state.messageError != null)
          Text('Erro: ${state.messageError!}',
              style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
