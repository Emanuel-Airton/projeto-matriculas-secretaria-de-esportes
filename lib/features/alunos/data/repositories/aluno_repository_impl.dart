import 'dart:async';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/aluno_remote_service.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/domain/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class AlunoRepositoryImpl implements AlunoRepository {
  final AlunoRemoteService _alunoRemoteService;
  AlunoRepositoryImpl(this._alunoRemoteService);

  List<AlunoModel> listAunoModel = [];

  @override
  Future<Result<List<AlunoModel>>> buscarAlunos() async {
    final result = await _alunoRemoteService.buscarAlunos();
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar lista de alunos'));
  }

  @override
  Future<Result<List<AlunoModel>>> buscarAlunoPNome(String nome) async {
    final result = await _alunoRemoteService.buscarAlunoPNome(nome);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar aluno por nome'));
  }

  @override
  Future<Result<List<dynamic>>> retornaIdListAlunos(String nomeAluno) async {
    final result = await _alunoRemoteService.retornaIdListAlunos(nomeAluno);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar Ids'));
  }

  @override
  Future<Result<AlunoModel>> cadastrarAluno(AlunoModel aluno) async {
    final result = await _alunoRemoteService.cadastrarAluno(aluno);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao salvar aluno'));
  }

  @override
  Future<Result<AlunoModel>> atualizarAluno(
      int alunoId, Map<String, dynamic> json) async {
    final result = await _alunoRemoteService.atualizarAluno(alunoId, json);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao atualizar os dados do aluno'));
  }

  @override
  Future<Result<void>> deletarAluno(int alunoId) async {
    final result = await _alunoRemoteService.deletarAluno(alunoId);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao deletar registro do aluno'));
  }

  //recebe a lista completa de alunos e separa a quantidade de acordo com o sexo
  Future<Result<Map<String, dynamic>>> quantidadeAlunoPorGenero(
      List<AlunoModel> listAlunos) async {
    try {
      final List listMasc = [];
      final List listFem = [];

      for (int i = 0; i < listAlunos.length; i++) {
        if (listAlunos[i].sexo == 'masculino') {
          listMasc.add(listAlunos[i]);
        } else {
          listFem.add(listAlunos[i]);
        }
      }
      return Result.ok({
        'total': listAlunos.length,
        'masculino': listMasc.length,
        'feminino': listFem.length
      });
    } on Exception catch (e) {
      return Result.error(Exception('Erro ao buscar lista'));
    }
  }
}
