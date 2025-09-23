import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/storage_service.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class ImageStorageRepository {
  final StorageService _storageService;
  ImageStorageRepository(this._storageService);

  Future<Result<String?>> uploadImageStorage(
      Map<String, dynamic> mapContentFile) async {
    final result = await _storageService.uploadImage(
        mapContentFile['fileName'], mapContentFile['filePath']);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscarImagem'));
  }
}
