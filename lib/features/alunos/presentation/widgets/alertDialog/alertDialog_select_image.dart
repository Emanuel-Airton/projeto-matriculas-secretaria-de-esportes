import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/image_storage_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/profile_image_widget.dart';

class AlertdialogSelectImage extends ConsumerStatefulWidget {
  const AlertdialogSelectImage({super.key});

  @override
  ConsumerState<AlertdialogSelectImage> createState() =>
      _AlertdialogSelectImageState();
}

class _AlertdialogSelectImageState
    extends ConsumerState<AlertdialogSelectImage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ProfileImageWidget(urlImage: ''),
      actions: [
        ElevatedButton(
            onPressed: () async {
              try {
                ref.read(uploadImageStorage);

                debugPrint('upload realizado com sucesso');
              } catch (e) {
                debugPrint('erro: $e');
              }
            },
            child: Text('Salvar imagem'))
      ],
    );
  }
}
