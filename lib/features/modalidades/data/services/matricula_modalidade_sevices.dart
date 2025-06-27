import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatriculaModalidadeSevices {
  final _supabase = Supabase.instance.client;
  static const String tabelaMatriculaModalidade = 'matricula_modalidade';
  static const String tabelaModalidade = 'modalidades';
  static const String buscarAluno =
      'nome, telefone, cpf, sexo, nascimento, rg, cpf, escola, turno, endereço, nome_mae, cpf_mae ';

  MatriculaModalidadeSevices();

  Future<ModalidadesModel> buscarModalidade(int id) async {
    final response =
        await _supabase.from(tabelaModalidade).select().eq('id', id);
    return response
        .map<ModalidadesModel>((json) => ModalidadesModel.fromJson(json))
        .single;
  }

  Future<List<ModalidadesModel>> buscarListaModalidade() async {
    buscarModalidade(1);
    final response = await _supabase.from(tabelaModalidade).select();
    return response.map<ModalidadesModel>((json) {
      debugPrint(json.toString());
      return ModalidadesModel.fromJson(json);
    }).toList();
  }

  //retorna a lista de todas as matriculas de acordo com o ID da modalidade
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadeFiltro(
      int id) async {
    try {
      final response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select('id, data_matricula, alunos($buscarAluno), modalidades(nome)')
          .filter('modalidade_id', 'eq', id)
          .order('data_matricula', ascending: true);
      return response.map<MatriculaModalidadesModel>(
        (json) {
          debugPrint('teste filtro: ${json.toString()}');
          return MatriculaModalidadesModel.fromJson(json);
        },
      ).toList();
    } catch (e) {
      debugPrint('Exceção: $e');
      throw Exception(e);
    }
  }

  //retorna a lista de todas as matriculas
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidade() async {
    try {
      final response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select(
              'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
          .order('data_matricula', ascending: true);
      return response.map<MatriculaModalidadesModel>(
        (json) {
          return MatriculaModalidadesModel.fromJson(json);
        },
      ).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Map<String, dynamic>>> buscarSemIdModalidade(
      String nomeAluno, dynamic idsAlunos) async {
    List<Map<String, dynamic>> response = await _supabase
        .from(tabelaMatriculaModalidade)
        .select(
            'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
        .inFilter('aluno_id', idsAlunos)
        .order('data_matricula', ascending: true);
    return response;
  }

  Future<List<Map<String, dynamic>>> buscarComIdModalidade(
      String nomeAluno, int idModalidade, dynamic idsAlunos) async {
    try {
      List<Map<String, dynamic>> response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select(
              'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
          .filter('modalidade_id', 'eq', idModalidade)
          .inFilter('aluno_id', idsAlunos)
          .order('data_matricula', ascending: true);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  deletarMatriculaModalidade(int id) async {
    try {
      await _supabase.from(tabelaMatriculaModalidade).delete().eq('id', id);
    } catch (erro) {
      throw 'Erro ao deletar matricula $erro';
    }
  }
}
