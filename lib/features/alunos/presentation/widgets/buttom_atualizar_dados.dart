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
        onPressed: () async {
          //final urlImagemAsync = ref.watch(uploadImageStorage);
          final urlImagemAsync = ref.refresh(uploadImageStorage.future);
          final url = await urlImagemAsync;

          if (url != null) {
            widget.json['foto_perfil_url'] =
                url; // Atualiza a URL da imagem no JSON
            debugPrint('URL da imagem: ${widget.json['foto_perfil_url']}');

            if (widget.json.isNotEmpty) {
              try {
                await ref
                    .read(alunoUseCaseProvider)
                    .atualizarAluno(widget.id, widget.json);
                debugPrint(widget.json.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Center(child: Text('Dados atualizados!'))),
                );
              } catch (e) {
                debugPrint('Erro ao atualizar dados: $e');
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Center(child: Text('Nenhuma alteração detectada!'))),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Center(child: Text('Erro ao fazer upload da imagem!'))),
            );
          }
        },
        child: Text('salvar alterações'));
  }
}
