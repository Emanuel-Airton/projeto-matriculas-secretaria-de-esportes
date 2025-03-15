import 'package:flutter/rendering.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/data/models/auth_model.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/data/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseAuthService _authService;

  AuthRepository(this._authService);

  // Método para fazer login e retornar um UserModel
  Future<UserModel> login(String email, String password) async {
    final AuthResponse response =
        await _authService.loginWithEmailAndPassword(email, password);
    final user = response.user;

    if (user == null) {
      throw Exception('Usuário não encontrado');
    }

    return UserModel(
      id: user.id,
      email: user.email ?? '',
    );
  }

  Future logout() async {
    final AuthResponse response = await _authService.logout();
    final user = response.user;
    if (user == null) {
      debugPrint('usuario não logado');
      //throw Exception('Usuário não encontrado');
    }
  }
}
