import 'dart:async';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/aluno_remote_service.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class AlunoRepository {
  //final _supabase = Supabase.instance.client;
  //final SupabaseClient _supabase;
  late final StreamController<List<AlunoModel>> _controller;
  AlunoRemoteService _alunoRemoteService;
  AlunoRepository(this._alunoRemoteService) {
    // _controller = StreamController.broadcast();
    //  setupRealTime();
  }
  /* Stream<List<AlunoModel>> watchAluno() {
    return _controller.stream;
  }*/

  /* AlunoRepository._(this._supabase);
  factory AlunoRepository(SupabaseClient supabase) {
    _instance ??= AlunoRepository._(supabase);
    return _instance!;
  }*/

  List<AlunoModel> listAunoModel = [];
  // Buscar todos os alunos
  Future<Result<List<AlunoModel>>> buscarAlunos() async {
    final result = await _alunoRemoteService.buscarAlunos();
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar lista de alunos'));
  }

  Future<Result<List<AlunoModel>>> buscarAlunoPNome(String nome) async {
    final result = await _alunoRemoteService.buscarAlunoPNome(nome);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar aluno por nome'));
  }

  Future<Result<List<dynamic>>> retornaIdListAlunos(String nomeAluno) async {
    final result = await _alunoRemoteService.retornaIdListAlunos(nomeAluno);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar Ids'));
  }

  // Cadastrar aluno
  Future<Result<AlunoModel>> cadastrarAluno(AlunoModel aluno) async {
    final result = await _alunoRemoteService.cadastrarAluno(aluno);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao salvar aluno'));
  }

  Future<Result<AlunoModel>> atualizarAluno(
      int alunoId, Map<String, dynamic> json) async {
    final result = await _alunoRemoteService.atualizarAluno(alunoId, json);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao atualizar os dados do aluno'));
  }

  Future<Result<void>> deletarAluno(int alunoId) async {
    final result = await _alunoRemoteService.deletarAluno(alunoId);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao deletar registro do aluno'));
  }
}
