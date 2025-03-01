import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/image_picker_repository.dart';

class PickImageUseCase {
  final ImageRepository _imageRepository;
  PickImageUseCase(this._imageRepository);
  Future<Map<String, dynamic>?> pickImage() async {
    return _imageRepository.pickImage();
  }

  uploadImage(Map<String, dynamic> map) {}
}
