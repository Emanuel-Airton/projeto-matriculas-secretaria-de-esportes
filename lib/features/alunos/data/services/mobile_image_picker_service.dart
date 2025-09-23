import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/image_picker_service.dart';

class MobileImagePickerService implements ImagePickerService {
  @override
  Future<Map<String, dynamic>?> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      return {
        'fileName': '${DateTime.now().millisecondsSinceEpoch}.jpg',
        'filePath': File(imageFile.path)
      };
    }
    return null;
  }
}
