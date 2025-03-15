import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final SupabaseClient _supabaseClient;

  SupabaseAuthService(this._supabaseClient);

  // Método para fazer login com email e senha
  Future<AuthResponse> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw 'Erro: ${e.code}';
    }
  }

  logout() async {
    return await _supabaseClient.auth.signOut();
  }

  // Método para obter o usuário atual (opcional)
  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }
}
