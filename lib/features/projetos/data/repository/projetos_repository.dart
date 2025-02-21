import 'package:projeto_secretaria_de_esportes/features/projetos/data/models/projetos_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjetosRepository {
  final _supabase = Supabase.instance.client;
  static const String tabelaProjetos = 'projetos';

  Future<List<ProjetosModel>> buscarProjeto() async {
    final response = await _supabase.from(tabelaProjetos).select();
    return response
        .map<ProjetosModel>((json) => ProjetosModel.fromJson(json))
        .toList();
  }
}
