import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final _supabase = Supabase.instance.client;
  Future<String?> uploadImage(String fileName, File pathFile) async {
    try {
      final response = await _supabase.storage.from('images').upload(
            fileName,
            pathFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      // final urlImage = _supabase.storage.from('images').getPublicUrl(fileName);
      // debugPrint('url da imagem: $urlImage');
      debugPrint('response: $response');
      return _supabase.storage.from('images').getPublicUrl(fileName);
    } catch (e) {
      debugPrint('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  downLoadImage(File pathFile) async {
    //  await
    final urlImage =
        await _supabase.storage.from('images').getPublicUrl(pathFile.path);
  }
}
