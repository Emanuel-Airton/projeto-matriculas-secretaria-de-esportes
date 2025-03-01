import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final _supabase = Supabase.instance.client;
  final String imageBucket = 'images';
  Future<String?> uploadImage(String fileName, File pathFile) async {
    try {
      await _supabase.storage.from(imageBucket).upload(
            fileName,
            pathFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      return _supabase.storage.from(imageBucket).getPublicUrl(fileName);
    } catch (e) {
      debugPrint('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }
}
