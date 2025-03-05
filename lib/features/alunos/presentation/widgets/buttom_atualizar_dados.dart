import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import '../providers/aluno_provider.dart';
import '../providers/image_storage_provider.dart';

class ButtomAtualizarDados extends ConsumerStatefulWidget {
  final int id;
  final Map<String, dynamic> json;
  ButtomAtualizarDados({super.key, required this.id, required this.json});

  @override
  ConsumerState<ButtomAtualizarDados> createState() =>
      _ButtomAtualizarDadosState();
}

class _ButtomAtualizarDadosState extends ConsumerState<ButtomAtualizarDados> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final urlImagemAsync = ref.watch(uploadImageStorage);
          urlImagemAsync.when(
            data: (data) {
              data != null ? widget.json['foto_perfil_url'] = data : null;
              debugPrint('data: ${widget.json['foto_perfil_url']}');
              if (widget.json.isNotEmpty) {
                try {
                  ref
                      .read(alunoUseCaseProvider)
                      .atualizarAluno(widget.id!, widget.json);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(
                    child: Text('dados atualizados!'),
                  )));
                } catch (e) {
                  debugPrint('erro ao atualizar dados: $e');
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Center(child: Text('Nenhuma alteração detectada!'))),
                );
              }
            },
            error: (error, stackTrace) {},
            loading: () {},
          );
        },
        child: Text('salvar alterações'));
  }
}
