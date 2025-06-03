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

  _fetchMatriculasModalidade({bool forcarBusca = false}) {
    state = AsyncValue.loading();
    try {
      if (cache.isNotEmpty && !forcarBusca) {
        state = AsyncValue.data(cache);
        debugPrint('cache contem dados');
        return;
      }
      buscarMatriculasModalidade();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  buscarMatriculasModalidade() async {
    Future.delayed(Duration(milliseconds: 500));
    cache = await _modalidadesUsecase.buscarMatriculaModalidade();
    state = AsyncValue.data(cache);
  }

  deletarMatriculaModalidade(int id) async {
    try {
      await _modalidadesUsecase.deletarMatriculaModalidade(id);
      cache = cache.where((matricula) => matricula.id != id).toList();
      state = AsyncValue.data(cache);
      _timer = Timer(Duration(milliseconds: 500),
          () => _fetchMatriculasModalidade(forcarBusca: true));
    } catch (e) {
      throw Exception(e);
    }
  }

  buscarMatriculaModalidadePnomeAluno(String value) async {
    try {
      cache =
          await _modalidadesUsecase.buscarMatriculaModalidadePnomeAluno(value);
      state = AsyncValue.data(cache);
      if (state.value!.isEmpty) {
        throw 'Aluno não encontrado!';
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
