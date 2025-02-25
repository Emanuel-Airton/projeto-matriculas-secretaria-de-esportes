import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/matricula_modalidades_model.dart';

class ModalidadesRepository {
  final _supabase = Supabase.instance.client;
  static const String tabelaMatriculaModalidade = 'matricula_modalidade';
  static const String tabelaModalidade = 'modalidades';

  Future<List<ModalidadesModel>> buscarModalidade() async {
    final response = await _supabase.from(tabelaModalidade).select();
    return response.map<ModalidadesModel>((json) {
      debugPrint(json.toString());
      return ModalidadesModel.fromJson(json);
    }).toList();
  }

  //retorna a lista de todas as matriculas de acordo com o ID
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadeFiltro(
      int id) async {
    final response = await _supabase
        .from(tabelaMatriculaModalidade)
        .select(
            'id, matriculas(data_matricula, alunos(nome, telefone, cpf, sexo, nascimento, rg, cpf, escola, turno, endereço)), modalidades(nome)')
        .filter('modalidade_id', 'eq', id);
    return response.map<MatriculaModalidadesModel>(
      (json) {
        debugPrint('teste filtro: ${json.toString()}');
        return MatriculaModalidadesModel.fromJson(json);
      },
    ).toList();
  }

  //retorna a lista de todas as matriculas
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidade() async {
    final response = await _supabase.from(tabelaMatriculaModalidade).select(
        'id, matricula_id, matriculas(data_matricula, alunos(nome, telefone, cpf, sexo, nascimento, rg, cpf, escola, turno, endereço)), modalidades(nome)');
    return response.map<MatriculaModalidadesModel>(
      (json) {
        debugPrint('teste: ${json.toString()}');
        return MatriculaModalidadesModel.fromJson(json);
      },
    ).toList();
  }

  deletarMatriculaModalidade(int id) async {
    try {
      await _supabase.from(tabelaMatriculaModalidade).delete().eq('id', id);
    } catch (erro) {
      throw 'Erro ao deletar matricula $erro';
    }
  }
}
