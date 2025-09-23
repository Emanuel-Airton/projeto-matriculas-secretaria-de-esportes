import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/image_picker_service.dart';

class DesktopImagePickerService implements ImagePickerService {
  @override
  Future<Map<String, dynamic>?> pickImage() async {
    final XFile? imageFile = await openFile(acceptedTypeGroups: [
      XTypeGroup(
        label: 'images',
        extensions: ['jpg', 'png', 'jpeg'],
      )
    ]);
    if (imageFile != null) {
      return {
        'fileName': '${DateTime.now().millisecondsSinceEpoch}.jpg',
        'filePath': File(imageFile.path)
      };
    }
    return null;
  }
}
