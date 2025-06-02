import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlunoRepository {
  //final _supabase = Supabase.instance.client;
  // static AlunoRepository? _instance;
  final SupabaseClient _supabase;
  late final StreamController<List<AlunoModel>> _controller;

  AlunoRepository(this._supabase) {
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
  }
*/
  List<AlunoModel> listAunoModel = [];
  // Buscar todos os alunos
  Future<List<AlunoModel>> buscarAlunos() async {
    final response =
        await _supabase.from('alunos').select().order('nome', ascending: true);
    listAunoModel =
        response.map<AlunoModel>((json) => AlunoModel.fromJson(json)).toList();
    //debugPrint('tamanho da lista 1: ${listAunoModel.length}');
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
      //debugPrint('tamanho da lista 2: ${listAunoModel.length}');
      return listAunoModel;
    } catch (e) {
      throw 'Erro ao buscar aluno: $e';
    }
  }

  Stream<List<AlunoModel>> watchAluno() {
    final controller = StreamController<List<AlunoModel>>.broadcast();
    final channel = _supabase
        .channel('alunos')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          table: 'alunos',
          schema: 'public',
          callback: (payload) async {
            debugPrint('Evento recebido: ${payload.eventType}');
            // debugPrint('Payload completo: ${payload.newRecord}');
            List<AlunoModel>? newList;
            try {
              //  final newItem = AlunoModel.fromJson(payload.newRecord);
              //    debugPrint('Item desserializado: ${newItem.toJson()}');

              // Adicione lógica para cada tipo de evento
              switch (payload.eventType) {
                case PostgresChangeEvent.insert:
                  debugPrint('Evento INSERT processado');
                  break;
                case PostgresChangeEvent.update:
                  debugPrint('Evento UPDATE processado');
                  List<AlunoModel> list = await controller.stream.first;
                  newList = list.map(
                    (e) {
                      return e.id == payload.newRecord['id']
                          ? AlunoModel.fromJson(payload.newRecord)
                          : e;
                    },
                  ).toList();

                  break;
                case PostgresChangeEvent.delete:
                  debugPrint('Evento DELETE processado');
                  /*  newList = list
                      .where((element) => element.id != payload.oldRecord['id'])
                      .toList();*/
                  break;
                case PostgresChangeEvent.all:
                  // TODO: Handle this case.
                  throw UnimplementedError();
              }
            } catch (e) {
              debugPrint('Erro ao processar evento: $e');
            }
            if (!controller.isClosed) {
              controller.add(newList!);
              debugPrint('controller: ${controller.stream.first.toString()}');
            }
          },
        )
        .subscribe();

    controller.onCancel = () {
      channel.unsubscribe();
    };

    return controller.stream;
  }

  /* setupRealTime() {
    //final controller = StreamController<List<AlunoModel>>();
    _supabase
        .channel('alunos')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            table: 'alunos',
            schema: 'public',
            callback: (payload) async {
              debugPrint(payload.eventType.name);
              List<AlunoModel> currentList =
                  _controller.isClosed ? [] : await _controller.stream.first;
              List<AlunoModel>? newList;
              
              if (payload.eventType == PostgresChangeEvent.insert) {
                newList = [
                  ...currentList,
                  AlunoModel.fromJson(payload.newRecord)
                ];
              } else if (payload.eventType == PostgresChangeEvent.update) {
                newList = currentList.map((aluno) {
                  return aluno.id == payload.newRecord['id']
                      ? AlunoModel.fromJson(payload.newRecord)
                      : aluno;
                }).toList();
              } else if (payload.eventType == PostgresChangeEvent.delete) {
                newList = currentList
                    .where((aluno) => aluno.id != payload.oldRecord['id'])
                    .toList();
              }
              if (!_controller.isClosed) {
                _controller.add(newList!);
              }
            })
        .subscribe();
    //listAunoModel.forEach((element) => debugPrint(element.nomeMae));
    // Fecha o stream quando não for mais necessário
    /*_controller.onCancel = () {
      channel.unsubscribe();
    };*/
    // return _controller.stream;
  }*/

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

  Future<List<dynamic>> buscarListAlunosPorNome(String nomeAluno) async {
    final response = await _supabase
        .from('alunos')
        .select('id')
        .like('nome', '%$nomeAluno%');
    if (response.isEmpty) return [];
    return response.map((e) => e['id']).toList();
  }

  // Cadastrar aluno
  Future<AlunoModel> cadastrarAluno(AlunoModel aluno) async {
    await _supabase.from('alunos').insert(aluno.toJson());
    return aluno;
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) async {
    await _supabase.from('alunos').update(json).eq('id', alunoId);
  }

  Future<void> deletarAluno(int alunoId) async {
    try {
      if (alunoId == 999) {
        throw Exception('erro id invalido');
      }
      await _supabase.from('alunos').delete().eq('id', alunoId);
    } catch (e) {
      rethrow;
    }
  }
}
