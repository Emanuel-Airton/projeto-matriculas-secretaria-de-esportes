import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatriculaModalidadeNotifier
    extends StateNotifier<AsyncValue<List<MatriculaModalidadesModel>>> {
  // final SupabaseClient _supabase;
  final ModalidadesUsecase _modalidadesUsecase;
  List<MatriculaModalidadesModel> cache = [];
  Timer? _timer;

  MatriculaModalidadeNotifier(this._modalidadesUsecase)
      : super(AsyncValue.data([])) {
    //_setupRealTime();
    _fetchMatriculasModalidade();
  }

  _fetchMatriculasModalidade({bool forcarBusca = false, int? idModalidade}) {
    state = AsyncValue.loading();
    try {
      if (cache.isNotEmpty && !forcarBusca) {
        state = AsyncValue.data(cache);
        debugPrint('cache contem dados');
        return;
      }
      if (idModalidade != null) {
        buscarMatriculasModalidadeFiltro(idModalidade);
        return;
      } else {
        buscarMatriculasModalidade();
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  buscarMatriculasModalidade() async {
    Future.delayed(Duration(milliseconds: 500));
    cache = await _modalidadesUsecase.buscarMatriculaModalidade();
    state = AsyncValue.data(cache);
  }

  deletarMatriculaModalidade(int idMatriculaModalidade,
      {int? idModalidade}) async {
    try {
      await _modalidadesUsecase
          .deletarMatriculaModalidade(idMatriculaModalidade);
      cache = cache
          .where((matricula) => matricula.id != idMatriculaModalidade)
          .toList();
      state = AsyncValue.data(cache);
      _timer = Timer(
          Duration(milliseconds: 500),
          () => _fetchMatriculasModalidade(
              forcarBusca: true, idModalidade: idModalidade));
    } catch (e) {
      throw Exception(e);
    }
  }

  buscarMatriculaModalidadePnomeAluno(String nomeAluno,
      {int? idModalidade}) async {
    debugPrint('id: ${idModalidade.toString()}');
    try {
      cache = await _modalidadesUsecase.buscarMatriculaModalidadePnomeAluno(
          nomeAluno,
          idModalidade: idModalidade);
      state = AsyncValue.data(cache);
      if (state.value!.isEmpty) {
        throw 'Matricula de aluno não encontrada!';
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  buscarMatriculasModalidadeFiltro(int id) async {
    state = AsyncValue.loading();
    Future.delayed(Duration(milliseconds: 500));
    cache = await _modalidadesUsecase.buscarMatriculaModalidadeFiltro(id);
    state = AsyncValue.data(cache);
  }

  /*_setupRealTime() {
    _supabase
        .channel('matricula_modalidade')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            table: 'matricula_modalidade',
            schema: 'public',
            callback: (payload) {
              debugPrint('Evento recebido: ${payload.eventType}');
              debugPrint('Payload: ${payload.newRecord}');

              try {
                if (payload.eventType == PostgresChangeEvent.insert) {
                  state = [
                    ...state,
                    MatriculaModalidadesModel.fromJson(payload.newRecord)
                  ];
                } else if (payload.eventType == PostgresChangeEvent.update) {
                  state = [
                    for (final matricula in state)
                      if (matricula.id == payload.newRecord['id'])
                        MatriculaModalidadesModel.fromJson(payload.newRecord)
                      else
                        matricula
                  ];
                } else if (payload.eventType == PostgresChangeEvent.delete) {
                  state = state
                      .where((element) => element.id != payload.oldRecord['id'])
                      .toList();

                  /*[
                    for (final matricula in state)
                      if (matricula.id != payload.oldRecord['id']) matricula
                  ];*/
                }
              } catch (e) {
                debugPrint('Erro ao processar payload: $e');
              }
            })
        .subscribe();
  }*/
}

final matriculaModalidade = StateNotifierProvider<MatriculaModalidadeNotifier,
    AsyncValue<List<MatriculaModalidadesModel>>>(
  (ref) {
    final supabase = Supabase.instance.client;
    final modalidadesRepository = ModalidadesRepository();
    final matriculaModalidadeUseCase =
        ModalidadesUsecase(modalidadesRepository);
    return MatriculaModalidadeNotifier(matriculaModalidadeUseCase);
  },
);
final matriculaModalidadeProvider = StateProvider<int?>((ref) => null);
