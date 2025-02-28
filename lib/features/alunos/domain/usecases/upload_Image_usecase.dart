import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/storage_service.dart';

class UploadImageUsecase {
  String? _imagePath;
  File? filePath;
  final StorageService _storageService;

  UploadImageUsecase(this._storageService);
  Future<Map<String, dynamic>?> execute() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        return await selectImageAndroidAndIOS();
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        return await selectImageWindows();
      }
      return null;
    } catch (e) {
      throw 'Erro: $e';
    }
  }

  Future<Map<String, dynamic>?> selectImageAndroidAndIOS() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final _filePath = imageFile.path;
      filePath = File(_filePath);
      Map<String, dynamic> map = {'fileName': fileName, 'filePath': filePath};

      return map;
    }
    return null;
  }

  Future<Map<String, dynamic>?> selectImageWindows() async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'png', 'jpeg'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      _imagePath = file.path;
      filePath = File(_imagePath!);
      Map<String, dynamic> map = {'fileName': fileName, 'filePath': filePath};
      return map;
    }
    return null;
  }

  Future<String?> uploadImage(Map pathFile) async {
    String? valor = await _storageService.uploadImage(
        pathFile['fileName'], pathFile['filePath']);
    debugPrint('valor $valor');
    return valor;
  }
}
