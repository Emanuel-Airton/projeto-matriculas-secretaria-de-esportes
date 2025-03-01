import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/image_storage_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/storage_service.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/domain/usecases/image_storage_use_case.dart';

final storageService = Provider((ref) => StorageService());
final imageStorageRepository =
    Provider((ref) => ImageStorageRepository(ref.read(storageService)));
final imageStorageUseCase =
    Provider((ref) => ImageStorageUseCase(ref.read(imageStorageRepository)));

final mapContentFileInfo = StateProvider<Map<String, dynamic>?>((ref) => null);
final uploadImageStorage = FutureProvider((ref) {
  final map = ref.read(mapContentFileInfo);
  if (map!.isNotEmpty) {
    return ref.read(imageStorageUseCase).uploadImageStorage(map);
  }
});
