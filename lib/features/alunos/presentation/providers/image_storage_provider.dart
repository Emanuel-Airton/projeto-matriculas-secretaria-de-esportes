import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/image_storage_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/storage_service.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

final storageService = Provider((ref) => StorageService());
final imageStorageRepository =
    Provider((ref) => ImageStorageRepository(ref.read(storageService)));

final mapContentFileInfo = StateProvider<Map<String, dynamic>?>((ref) => null);
final stringUrlImage = StateProvider<String?>((ref) => null);

final uploadImageStorage = FutureProvider<String?>((ref) async {
  final map = ref.read(mapContentFileInfo);
  if (map != null && map.isNotEmpty) {
    Result<String?> result =
        await ref.read(imageStorageRepository).uploadImageStorage(map);
    switch (result) {
      case Ok<String?>():
        return result.value;
      case Error<String?>():
        throw result.error;
    }
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
