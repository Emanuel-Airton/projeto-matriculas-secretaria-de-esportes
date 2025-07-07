import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatriculaModalidadeSevices {
  final _supabase = Supabase.instance.client;
  static const String tabelaMatriculaModalidade = 'matricula_modalidade';
  static const String tabelaModalidade = 'modalidades';
  static const String buscarAluno =
      'nome, telefone, cpf, sexo, nascimento, rg, cpf, escola, turno, endereço, nome_mae, cpf_mae ';

  MatriculaModalidadeSevices();

  Future<Result<ModalidadesModel>> buscarModalidade(int id) async {
    try {
      final response =
          await _supabase.from(tabelaModalidade).select().eq('id', id);
      return Result.ok(response
          .map<ModalidadesModel>((json) => ModalidadesModel.fromJson(json))
          .single);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

//service
  Future<Result<List<ModalidadesModel>>> buscarListaModalidade() async {
    try {
      final response = await _supabase.from(tabelaModalidade).select();
      return Result.ok(response
          .map<ModalidadesModel>((json) => ModalidadesModel.fromJson(json))
          .toList());
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  //retorna a lista de todas as matriculas de acordo com o ID da modalidade
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidadeFiltro(int id) async {
    try {
      final response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select('id, data_matricula, alunos($buscarAluno), modalidades(nome)')
          .filter('modalidade_id', 'eq', id)
          .order('data_matricula', ascending: true);
      return Result.ok(response
          .map<MatriculaModalidadesModel>(
              (json) => MatriculaModalidadesModel.fromJson(json))
          .toList());
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  //retorna a lista de todas as matriculas
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidade() async {
    try {
      final response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select(
              'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
          .order('data_matricula', ascending: true);

      return Result.ok(response
          .map<MatriculaModalidadesModel>(
              (json) => MatriculaModalidadesModel.fromJson(json))
          .toList());
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<MatriculaModalidadesModel>>> buscarSemIdModalidade(
      String nomeAluno, dynamic idsAlunos) async {
    try {
      List<Map<String, dynamic>> response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select(
              'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
          .inFilter('aluno_id', idsAlunos)
          .order('data_matricula', ascending: true);
      return Result.ok(response
          .map((json) => MatriculaModalidadesModel.fromJson(json))
          .toList());
    } on Exception catch (e) {
      debugPrint('ERRO');
      return Result.error(e);
    }
  }

  Future<Result<List<MatriculaModalidadesModel>>> buscarComIdModalidade(
      String nomeAluno, int idModalidade, dynamic idsAlunos) async {
    try {
      List<Map<String, dynamic>> response = await _supabase
          .from(tabelaMatriculaModalidade)
          .select(
              'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
          .filter('modalidade_id', 'eq', idModalidade)
          .inFilter('aluno_id', idsAlunos)
          .order('data_matricula', ascending: true);
      return Result.ok(response
          .map((json) => MatriculaModalidadesModel.fromJson(json))
          .toList());
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

// classe service
  Future<Result> deletarMatriculaModalidade(int id) async {
    try {
      await _supabase.from(tabelaMatriculaModalidade).delete().eq('id', id);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
