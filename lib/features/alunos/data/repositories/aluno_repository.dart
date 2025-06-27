import 'dart:async';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/aluno_remote_service.dart';

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
  Future<List<AlunoModel>> buscarAlunos() async {
    return _alunoRemoteService.buscarAlunos();
  }

  Future<List<AlunoModel>> buscarAlunoPNome(String nome) async {
    return _alunoRemoteService.buscarAlunoPNome(nome);
  }

  /* Stream<List<AlunoModel>> watchAluno() {
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
  }*/

  Stream<List<AlunoModel>> buscarAlunosListen(int count) {
    return _alunoRemoteService.buscarAlunosListen(count);
  }

  Stream<List<AlunoModel>> buscarAlunoPorNomeStream(String nome) {
    return _alunoRemoteService.buscarAlunoPorNomeStream(nome);
  }

  Future<List<dynamic>> buscarListAlunosPorNome(String nomeAluno) async {
    return _alunoRemoteService.buscarListAlunosPorNome(nomeAluno);
  }

  // Cadastrar aluno
  Future<AlunoModel> cadastrarAluno(AlunoModel aluno) async {
    return _alunoRemoteService.cadastrarAluno(aluno);
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) async {
    return _alunoRemoteService.atualizarAluno(alunoId, json);
  }

  Future<void> deletarAluno(int alunoId) async {
    _alunoRemoteService.deletarAluno(alunoId);
  }
}
