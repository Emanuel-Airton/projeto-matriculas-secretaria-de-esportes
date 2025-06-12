import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/providers/button_save_matricula_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/providers/matricula_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/matricula_modalidade_notifier.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/modalidades_provider.dart';

class ElevatedbuttonSalvarMatricula extends ConsumerWidget {
  final int? alunoSelecionado;
  final List<int> modalidadesSelecionadas;
  const ElevatedbuttonSalvarMatricula(
      {super.key,
      required this.alunoSelecionado,
      required this.modalidadesSelecionadas});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonSaveMatricula = ref.watch(buttonSaveMatriculaProvider);
    return ElevatedButton(
      onPressed: buttonSaveMatricula.isloading
          ? null
          : () async {
              if (alunoSelecionado != null &&
                  modalidadesSelecionadas.isNotEmpty) {
                try {
                  await ref
                      .read(buttonSaveMatriculaProvider.notifier)
                      .saveButton(() async {
                    await ref
                        .read(matriculaUseCaseProvider)
                        .cadastrarMatriculaComModalidades(
                          alunoSelecionado!,
                          modalidadesSelecionadas,
                        );
                    ref.read(selectedModalidadeIdProvider.notifier).state =
                        null;
                    await ref
                        .read(matriculaModalidade.notifier)
                        .buscarMatriculasModalidade();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(
                    child: Text('Matricula realizada com sucesso'),
                  )));
                  Navigator.pop(context);
                } catch (erro) {
                  debugPrint('Erro: $erro');

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(
                    child: Text('O aluno já está matriculado nessa modalidade'),
                  )));
                }
              }
            },
      child: buttonSaveMatricula.isloading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            )
          : Text('Salvar Matrícula de modalidade'),
    );
  }
}
