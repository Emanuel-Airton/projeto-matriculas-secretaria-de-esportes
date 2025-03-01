import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/image_picker_service.dart';

class DesktopImagePickerService implements ImagePickerService {
  @override
  Future<Map<String, dynamic>?> pickImage() async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'png', 'jpeg'],
    );
    final XFile? imageFile = await openFile(acceptedTypeGroups: [typeGroup]);
    if (imageFile != null) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Map<String, dynamic> mapContentImageFile = {
        'fileName': fileName,
        'filePath': File(imageFile.path)
      };
      debugPrint(mapContentImageFile.toString());
      return mapContentImageFile;
    }
    return null;
  }
}
