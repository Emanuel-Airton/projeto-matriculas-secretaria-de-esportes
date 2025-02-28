import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlunoRepository {
  final _supabase = Supabase.instance.client;

  // Buscar todos os alunos
  Future<List<AlunoModel>> buscarAlunos() async {
    //  buscarAlunosListen();
    final response = await _supabase.from('alunos').select();
    return response
        .map<AlunoModel>((json) => AlunoModel.fromJson(json))
        .toList();
  }

  Stream<List<AlunoModel>> buscarAlunosListen() {
    return _supabase
        .from('alunos')
        .stream(primaryKey: ['id']) // Define a chave primária
        .order('id', ascending: true) // Ordena por ID
        .map((data) =>
            data.map<AlunoModel>((json) => AlunoModel.fromJson(json)).toList());
  }

  // Cadastrar aluno
  Future<void> cadastrarAluno(AlunoModel aluno) async {
    await _supabase.from('alunos').insert(aluno.toJson());
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) async {
    await _supabase.from('alunos').update(json).eq('id', alunoId);
  }

  // StreamController para armazenar os alunos em tempo real
  final StreamController<List<AlunoModel>> _alunosController =
      StreamController.broadcast();

  AlunoRepository() {
    // Inicia ouvindo as mudanças na tabela 'alunos'
    _supabase
        .from('alunos')
        .stream(primaryKey: ['id'])
        .order('id', ascending: true)
        .listen((data) {
          final alunos = data
              .map<AlunoModel>((json) => AlunoModel.fromJson(json))
              .toList();
          _alunosController
              .add(alunos); // Atualiza os dados no StreamController
        });

    // Escutar eventos do Supabase Realtime (INSERT, UPDATE, DELETE)
  }

  // Método para retornar o stream
}
