import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/image_storage_repository.dart';

class ImageStorageUseCase {
  final ImageStorageRepository _imageStorageRepository;
  ImageStorageUseCase(this._imageStorageRepository);
  Future<String?> uploadImageStorage(
      Map<String, dynamic> mapContentFile) async {
    return await _imageStorageRepository.uploadImageStorage(mapContentFile);
  }
}
