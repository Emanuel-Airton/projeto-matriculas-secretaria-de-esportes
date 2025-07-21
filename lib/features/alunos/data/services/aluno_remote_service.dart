import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlunoRemoteService {
  final SupabaseClient _supabase;
  AlunoRemoteService(this._supabase);

  Future<Result<List<AlunoModel>>> buscarAlunos() async {
    try {
      final response = await _supabase
          .from('alunos')
          .select()
          .order('nome', ascending: true);
      return Result.ok(response
          .map<AlunoModel>((json) => AlunoModel.fromJson(json))
          .toList());
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

//retorna todos os alunos com o nome especifico passado
  Future<Result<List<AlunoModel>>> buscarAlunoPNome(String nomeAluno) async {
    try {
      final response = await _supabase
          .from('alunos')
          .select()
          .like('nome', '%$nomeAluno%')
          .order('id', ascending: true);
      return Result.ok(response
          .map<AlunoModel>((json) => AlunoModel.fromJson(json))
          .toList());
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  //retorna o ID dos alunos de acordo com o nome passado
  Future<Result<List<dynamic>>> retornaIdListAlunos(String nomeAluno) async {
    try {
      final response = await _supabase
          .from('alunos')
          .select('id')
          .like('nome', '%$nomeAluno%');
      if (response.isEmpty) return Result.ok([]);
      return Result.ok(response.map((e) => e['id']).toList());
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  Stream<List<AlunoModel>> buscarAlunosListen() {
    return _supabase
        .from('alunos')
        .stream(primaryKey: ['id']) // Define a chave primária
        .order('id', ascending: true) // Ordena por ID
        .map((data) =>
            data.map<AlunoModel>((json) => AlunoModel.fromJson(json)).toList());
  }

  Future<Result<AlunoModel>> cadastrarAluno(AlunoModel aluno) async {
    try {
      await _supabase.from('alunos').insert(aluno.toJson());
      return Result.ok(aluno);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<AlunoModel>> atualizarAluno(
      int alunoId, Map<String, dynamic> json) async {
    try {
      await _supabase.from('alunos').update(json).eq('id', alunoId);
      Result result = await buscarAluno(alunoId);
      if (result is Ok) return Result.ok(AlunoModel.fromJson(result.value));
      return Result.error(Exception('erro ao buscar aluno'));
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<Map<String, dynamic>>> buscarAluno(int alunoId) async {
    try {
      final aluno = await _supabase.from('alunos').select().eq('id', alunoId);
      return Result.ok(aluno.map((e) => e).first);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> deletarAluno(int alunoId) async {
    try {
      await _supabase.from('alunos').delete().eq('id', alunoId);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(Exception(e));
    }
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
            //debugPrint('Evento recebido: ${payload.eventType}');
            // debugPrint('Payload completo: ${payload.newRecord}');
            List<AlunoModel>? newList;
            try {
             final newItem = AlunoModel.fromJson(payload.newRecord);
              //    debugPrint('Item desserializado: ${newItem.toJson()}');

              // Adicione lógica para cada tipo de evento
              switch (payload.eventType) {
                case PostgresChangeEvent.insert:
                //  debugPrint('Evento INSERT processado');
                  break;
                case PostgresChangeEvent.update:
               //   debugPrint('Evento UPDATE processado');
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
                //  debugPrint('Evento DELETE processado');
                    newList = list
                      .where((element) => element.id != payload.oldRecord['id'])
                      .toList();
                  break;
                case PostgresChangeEvent.all:
                  // TODO: Handle this case.
                  throw UnimplementedError();
              }
            } catch (e) {
              //debugPrint('Erro ao processar evento: $e');
            }
            if (!controller.isClosed) {
              controller.add(newList!);
              //debugPrint('controller: ${controller.stream.first.toString()}');
            }
          },
        )
        .subscribe();

    controller.onCancel = () {
      channel.unsubscribe();
    };

    return controller.stream;
  }*/
}
