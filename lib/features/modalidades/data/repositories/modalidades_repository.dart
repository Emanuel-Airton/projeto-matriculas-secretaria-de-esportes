import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/matricula_modalidades_model.dart';

class ModalidadesRepository {
  final _supabase = Supabase.instance.client;

  Future<List<ModalidadesModel>> buscarModalidade() async {
    final response = await _supabase.from('modalidades').select();
    return response.map<ModalidadesModel>((json) {
      debugPrint(json.toString());
      return ModalidadesModel.fromJson(json);
    }).toList();
  }

  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadeFiltro(
      int id) async {
    final response = await _supabase
        .from('matricula_modalidade')
        .select(
            'id, matriculas(alunos(nome, telefone, cpf, sexo, nascimento, rg, cpf)), modalidades(nome)')
        .filter('modalidade_id', 'eq', id);
    return response.map<MatriculaModalidadesModel>(
      (json) {
        debugPrint('teste filtro: ${json.toString()}');
        return MatriculaModalidadesModel.fromJson(json);
      },
    ).toList();
  }

  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidade() async {
    final response = await _supabase.from('matricula_modalidade').select(
        'id, matriculas(alunos(nome, telefone, cpf, sexo, nascimento, rg, cpf)), modalidades(nome)');
    return response.map<MatriculaModalidadesModel>(
      (json) {
        debugPrint('teste: ${json.toString()}');
        return MatriculaModalidadesModel.fromJson(json);
      },
    ).toList();
  }
}
