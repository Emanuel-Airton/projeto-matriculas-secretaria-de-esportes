import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final _supabase = Supabase.instance.client;
  static const String imageBucket = 'images';
  Future<Result<String?>> uploadImage(String fileName, File pathFile) async {
    try {
      await _supabase.storage.from(imageBucket).upload(
            fileName,
            pathFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );
      debugPrint(
          'upload feito: ${_supabase.storage.from(imageBucket).getPublicUrl(fileName)}');
      return Result.ok(
          _supabase.storage.from(imageBucket).getPublicUrl(fileName));
    } catch (e) {
      debugPrint('Erro ao fazer upload da imagem: $e');
      return Result.error(Exception(e));
    }
  }
}
