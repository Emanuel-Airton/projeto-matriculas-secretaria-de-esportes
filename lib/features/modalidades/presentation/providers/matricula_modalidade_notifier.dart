import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatriculaModalidadeNotifier
    extends StateNotifier<List<MatriculaModalidadesModel>> {
  final SupabaseClient _supabase;
  final ModalidadesUsecase _modalidadesUsecase;
  MatriculaModalidadeNotifier(this._supabase, this._modalidadesUsecase)
      : super([]) {
    _setupRealTime();
    buscarMatriculasModalidade();
  }
  buscarMatriculasModalidade() async {
    state = await _modalidadesUsecase.buscarMatriculaModalidade();
  }

  deletarMatriculaModalidade(int id) async {
    await _modalidadesUsecase.deletarMatriculaModalidade(id);
    state = state.where((matricula) => matricula.id != id).toList();
  }

  buscarMatriculasModalidadeFiltro(int id) async {
    state = await _modalidadesUsecase.buscarMatriculaModalidadeFiltro(id);
  }

  _setupRealTime() {
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
  }
}

final matriculaModalidade = StateNotifierProvider<MatriculaModalidadeNotifier,
    List<MatriculaModalidadesModel>>(
  (ref) {
    final supabase = Supabase.instance.client;
    final modalidadesRepository = ModalidadesRepository();
    final matriculaModalidadeUseCase =
        ModalidadesUsecase(modalidadesRepository);
    return MatriculaModalidadeNotifier(supabase, matriculaModalidadeUseCase);
  },
);
final matriculaModalidadeProvider = StateProvider<int?>((ref) => null);
