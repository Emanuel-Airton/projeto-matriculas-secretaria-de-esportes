import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/image_picker_provider.dart';
import '../providers/image_storage_provider.dart';

class ProfileImageWidget extends ConsumerStatefulWidget {
  final String urlImage;
  const ProfileImageWidget({super.key, required this.urlImage});

  @override
  ConsumerState<ProfileImageWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<ProfileImageWidget> {
  File? file;
  bool contenArquivo = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      //backgroundImage: NetworkImage(imageUrl),
      radius: 50,
      backgroundImage: file != null
          ? FileImage(file!)
          : widget.urlImage != ''
              ? NetworkImage(widget.urlImage)
              : null,
      child: Tooltip(
        message: 'Adicionar foto do perfil',
        child: IconButton(
            onPressed: () async {
              try {
                ref.read(mapContentFileInfo.notifier).state = {};
                Map<String, dynamic>? map =
                    await ref.read(pickImageUseCase).pickImage();
                setState(() {
                  file = map!['filePath'];
                  debugPrint('nome do arquivo ${map['fileName']}');
                  debugPrint('caminho do arquivo: ${file!.path}');
                  ref.read(mapContentFileInfo.notifier).state = map;
                });
                // debugPrint('teste: $file');
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            icon: Icon(
                file != null || widget.urlImage != '' ? null : Icons.person,
                size: 50)),
      ),
    );
  }
}
