import 'package:flutter/material.dart';
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
final stringUrlImage = StateProvider<String?>((ref) => null);

final uploadImageStorage = FutureProvider((ref) async {
  final map = ref.read(mapContentFileInfo);
  debugPrint('map: ${ref.read(mapContentFileInfo)}');
  if (map != null && map.isNotEmpty) {
    //String? url = await ref.watch(imageStorageUseCase).uploadImageStorage(map);
    //  ref.read(stringUrlImage.notifier).state = url;
    return ref.read(imageStorageUseCase).uploadImageStorage(map);
  }
});

final obterUrlImage = FutureProvider<String?>((ref) {
  final urlImagem = ref.watch(stringUrlImage);
  if (urlImagem != null && urlImagem.isNotEmpty) {
    debugPrint('urlImagem: $urlImagem');
    return ref.read(stringUrlImage);
  }
  return null;
});

final obterMapContentInfo = FutureProvider<Map<String, dynamic>?>((ref) {
  return ref.read(mapContentFileInfo);
});
