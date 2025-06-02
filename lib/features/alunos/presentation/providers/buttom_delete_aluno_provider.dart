import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/shared/providers/button_notifier.dart';

final buttonDeleteAlunoProvider =
    StateNotifierProvider<ButtonNotifier, ButtonState>(
        (ref) => ButtonNotifier());
