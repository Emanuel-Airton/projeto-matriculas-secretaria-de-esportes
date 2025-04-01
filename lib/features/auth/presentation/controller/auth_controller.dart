import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/data/models/auth_model.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/data/repository/auth_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/data/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading(); // Indica que o login está em andamento
    try {
      final user = await _authRepository.login(email, password);
      state = AsyncValue.data(user);
      debugPrint(
          'email logado: ${state.value?.email}'); // Atualiza o estado com o usuário logado
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // Indica erro no login
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading(); // Indica que o login está em andamento
    try {
      final user = await _authRepository.logout();
      state = AsyncValue.data(user); // Atualiza o estado com o usuário logado
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // Indica erro no login
    }
  }
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<UserModel?>>((ref) {
  final supabaseClient = Supabase.instance.client;
  final authService = SupabaseAuthService(supabaseClient);
  final authRepository = AuthRepository(authService);
  return AuthViewModel(authRepository);
});
