import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/alunoNotifier.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import '../../providers/image_storage_provider.dart';

class ButtomAtualizarDados extends ConsumerStatefulWidget {
  final int id;
  final Map<String, dynamic> json;
  const ButtomAtualizarDados({super.key, required this.id, required this.json});

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
              Result result = await ref
                  .read(alunoNotifierProvider.notifier)
                  .atualizarDadosAlunos(widget.id, widget.json);
              final msg = result is Error
                  ? '${result.error}'
                  : 'Erro ao atualizar dados';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Center(child: Text(msg))),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Center(child: Text('Nenhuma alteração detectada!'))),
              );
            }
          } else if (widget.json.isNotEmpty) {
            Result result = await ref
                .read(alunoNotifierProvider.notifier)
                .atualizarDadosAlunos(widget.id, widget.json);
            final msg = result is Error
                ? '${result.error}'
                : 'Dados atualizados com sucesso';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(child: Text(msg))),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Center(child: Text('Nenhuma alteração detectada!'))),
            );
          }
        },
        child: Text('salvar alterações'));
  }
}
