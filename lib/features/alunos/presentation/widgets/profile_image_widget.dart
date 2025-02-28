import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/aluno_provider.dart';

class ProfileImageWidget extends ConsumerStatefulWidget {
  final String urlImage;
  const ProfileImageWidget({super.key, required this.urlImage});

  @override
  ConsumerState<ProfileImageWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<ProfileImageWidget> {
  File? teste;
  bool contenArquivo = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      //backgroundImage: NetworkImage(imageUrl),
      radius: 50,
      backgroundImage: teste != null
          ? FileImage(teste!)
          : widget.urlImage != ''
              ? NetworkImage(widget.urlImage)
              : null,
      child: Tooltip(
        message: 'Adicionar foto do perfil',
        child: IconButton(
            onPressed: () async {
              try {
                Map<String, dynamic>? map =
                    await ref.read(uploadImageUsecase).execute();
                setState(() {
                  teste = map!['filePath'];
                  debugPrint(map['fileName']);
                  debugPrint('teste valor: ${teste!.path}');
                  ref.read(urlImage.notifier).state = map;
                });
                debugPrint('teste: $teste');
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            icon: Icon(
                teste != null || widget.urlImage != '' ? null : Icons.person,
                size: 50)),
      ),
    );
  }
}
