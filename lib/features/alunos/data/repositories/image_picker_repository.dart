import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/image_picker_service.dart';

class ImageRepository {
  final ImagePickerService _imagePickerService;
  ImageRepository(this._imagePickerService);

  Future<Map<String, dynamic>?> pickImage() async {
    return _imagePickerService.pickImage();
  }
}
