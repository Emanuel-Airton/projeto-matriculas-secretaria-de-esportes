import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/image_picker_repository.dart';
import '../../data/services/desktop_image_picker_service.dart';
import '../../data/services/mobile_image_picker_service.dart';

final imagePickerService =
    kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS
        ? DesktopImagePickerService()
        : MobileImagePickerService();

final image = Provider((ref) => imagePickerService);
final imageRepository = Provider((ref) => ImageRepository(ref.read(image)));
