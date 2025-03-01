import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/image_picker_service.dart';

class MobileImagePickerService implements ImagePickerService {
  @override
  Future<Map<String, dynamic>?> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Map<String, dynamic> mapContentImageFile = {
        'fileName': fileName,
        'filePath': File(imageFile.path)
      };
      return mapContentImageFile;
    }
    return null;
  }
}
