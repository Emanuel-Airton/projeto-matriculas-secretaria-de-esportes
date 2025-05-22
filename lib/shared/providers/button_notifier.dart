import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonState {
  final bool isloading;
  final bool isSucess;
  final String? messageError;

  ButtonState(
      {this.isloading = false, this.isSucess = false, this.messageError});

  ButtonState copyWith(
      {bool? isloading, bool? isSucess, String? messageError}) {
    return ButtonState(
        isloading: isloading ?? this.isloading,
        isSucess: isSucess ?? this.isSucess,
        messageError: messageError ?? this.messageError);
  }
}

class ButtonNotifier extends StateNotifier<ButtonState> {
  ButtonNotifier() : super(ButtonState());

  Future saveButton(Future Function() function) async {
    state = state.copyWith(isloading: true, isSucess: false);
    try {
      await Future.delayed(Duration(seconds: 1));
      state = state.copyWith(isloading: false, isSucess: true);
      await function();
    } catch (e) {
      state = state.copyWith(isloading: false, messageError: e.toString());
    }
  }

  resetButtonState() {
    state = ButtonState();
  }
}
