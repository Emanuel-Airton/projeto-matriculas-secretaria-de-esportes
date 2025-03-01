import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/storage_service.dart';

class ImageStorageRepository {
  StorageService _storageService;
  ImageStorageRepository(this._storageService);

  uploadImageStorage(Map<String, dynamic?> mapContentFile) {
    return _storageService.uploadImage(
        mapContentFile['fileName'], mapContentFile['filePath']);
  }
}
