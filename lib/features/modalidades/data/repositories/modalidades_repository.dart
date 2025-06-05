import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/domain/usecases/aluno_usecase.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/matricula_modalidades_model.dart';

class ModalidadesRepository {
  final _supabase = Supabase.instance.client;
  List<MatriculaModalidadesModel> list = [];
  static const String tabelaMatriculaModalidade = 'matricula_modalidade';
  static const String tabelaModalidade = 'modalidades';
  static const String buscarAluno =
      'nome, telefone, cpf, sexo, nascimento, rg, cpf, escola, turno, endereço, nome_mae, cpf_mae ';

  Future<ModalidadesModel> buscarModalidade(int id) async {
    final response =
        await _supabase.from(tabelaModalidade).select().eq('id', id);
    Map<String, dynamic> map = {};
    for (var item in response) {
      map = item;
    }
    return ModalidadesModel.fromJson(map);
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
    final response = await _supabase
        .from(tabelaMatriculaModalidade)
        .select('id, data_matricula, alunos($buscarAluno), modalidades(nome)')
        .filter('modalidade_id', 'eq', id)
        .order('data_matricula', ascending: true);
    list = response.map<MatriculaModalidadesModel>(
      (json) {
        debugPrint('teste filtro: ${json.toString()}');
        return MatriculaModalidadesModel.fromJson(json);
      },
    ).toList();
    return list;
  }

  //retorna a lista de todas as matriculas
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidade() async {
    debugPrint('teste: ');
    final response = await _supabase
        .from(tabelaMatriculaModalidade)
        .select(
            'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
        .order('data_matricula', ascending: true);
    list = response.map<MatriculaModalidadesModel>(
      (json) {
        // debugPrint('teste: ${json.toString()}');
        return MatriculaModalidadesModel.fromJson(json);
      },
    ).toList();
    return list;
  }

  buscarIdsAlunos(String nomeAluno) async {
    var alunoRepository = AlunoRepository(Supabase.instance.client);

    AlunoUseCase alunoUseCase = AlunoUseCase(alunoRepository);
    final idsAlunos = await alunoUseCase.buscarListAlunosPorNome(nomeAluno);
    return idsAlunos;
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
    // debugPrint('buscarComIdModalidade');
    List<Map<String, dynamic>> response = await _supabase
        .from(tabelaMatriculaModalidade)
        .select(
            'id, data_matricula, aluno_id, alunos($buscarAluno), modalidades(nome)')
        .filter('modalidade_id', 'eq', idModalidade)
        .inFilter('aluno_id', idsAlunos)
        .order('data_matricula', ascending: true);
    return response;
  }

  deletarMatriculaModalidade(int id) async {
    try {
      await _supabase.from(tabelaMatriculaModalidade).delete().eq('id', id);
    } catch (erro) {
      throw 'Erro ao deletar matricula $erro';
    }
  }
}
