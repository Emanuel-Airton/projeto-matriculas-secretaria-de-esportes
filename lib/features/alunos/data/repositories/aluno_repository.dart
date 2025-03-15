import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlunoRepository {
  final _supabase = Supabase.instance.client;
  List<AlunoModel> listAunoModel = [];
  // Buscar todos os alunos
  Future<List<AlunoModel>> buscarAlunos() async {
    final response = await _supabase
        .from('alunos')
        .select()
        .limit(20)
        .order('nome', ascending: true);
    listAunoModel =
        response.map<AlunoModel>((json) => AlunoModel.fromJson(json)).toList();
    debugPrint('tamanho da lista 1: ${listAunoModel.length}');
    return listAunoModel;
  }

  Future<List<AlunoModel>> buscarAlunoPNome(String nome) async {
    try {
      final response = await _supabase
          .from('alunos')
          .select()
          .like('nome', '%$nome%')
          .order('id', ascending: true);
      listAunoModel = response
          .map<AlunoModel>((json) => AlunoModel.fromJson(json))
          .toList();
      debugPrint('tamanho da lista 2: ${listAunoModel.length}');

      return listAunoModel;
    } catch (e) {
      throw 'Erro ao buscar aluno: $e';
    }
  }

  List<AlunoModel> setupRealTime() {
    _supabase
        .channel('alunos')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            table: 'alunos',
            schema: 'public',
            callback: (payload) {
              debugPrint('tamanho da lista 3: ${listAunoModel.length}');

              if (payload.eventType == PostgresChangeEvent.insert) {
                listAunoModel.add(AlunoModel.fromJson(payload.newRecord));
              } else if (payload.eventType == PostgresChangeEvent.update) {
                int index = listAunoModel.indexWhere(
                    (element) => element.id == payload.newRecord['id']);
                listAunoModel[index] = AlunoModel.fromJson(payload.newRecord);
                debugPrint('aluno atualizado: ${listAunoModel[index].nome}');
              } else {
                debugPrint('Evento não tratado: ${payload.eventType}');
              }
            })
        .subscribe();
    listAunoModel.forEach((element) => debugPrint(element.nomeMae));
    return listAunoModel;
  }

  Stream<List<AlunoModel>> buscarAlunosListen(int count) {
    try {
      return _supabase
          .from('alunos')
          .stream(primaryKey: ['id']) // Define a chave primária
          .limit(count) //define um limite de intens por consulta
          .order('id', ascending: true) // Ordena por ID
          .map((data) => data
              .map<AlunoModel>((json) => AlunoModel.fromJson(json))
              .toList());
    } catch (e) {
      // debugPrint(e.toString());
      throw 'Erro: $e';
    }
  }

  Stream<List<AlunoModel>> buscarAlunoPorNomeStream(String nome) {
    try {
      return _supabase
          .from('alunos')
          .stream(primaryKey: ['id'])
          .eq('nome', nome)
          .order('id', ascending: true)
          .map((data) => data
              .map<AlunoModel>((json) => AlunoModel.fromJson(json))
              .toList());
    } catch (e) {
      throw 'Erro ao buscar aluno: $e';
    }
  }

  // Cadastrar aluno
  Future<void> cadastrarAluno(AlunoModel aluno) async {
    await _supabase.from('alunos').insert(aluno.toJson());
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) async {
    await _supabase.from('alunos').update(json).eq('id', alunoId);
  }

  Future<void> deletarAluno(int alunoId) async {
    try {
      await _supabase.from('alunos').delete().eq('id', alunoId);
    } catch (e) {
      throw 'Erro ao deletar aluno';
    }
  }
}
