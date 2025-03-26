import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/storage_service.dart';

class ImageStorageRepository {
  final StorageService _storageService;
  ImageStorageRepository(this._storageService);

  Future<String?> uploadImageStorage(
      Map<String, dynamic> mapContentFile) async {
    return await _storageService.uploadImage(
        mapContentFile['fileName'], mapContentFile['filePath']);
  }
}
