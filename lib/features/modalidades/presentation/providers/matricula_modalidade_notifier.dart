import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/modalidades_provider.dart';

class MatriculaModalidadeNotifier
    extends StateNotifier<AsyncValue<List<MatriculaModalidadesModel>>> {
  final ModalidadesUsecase _modalidadesUsecase;
  List<MatriculaModalidadesModel> cache = [];
  Timer? _timer;

  MatriculaModalidadeNotifier(this._modalidadesUsecase)
      : super(AsyncValue.data([])) {
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
}

final matriculaModalidade = StateNotifierProvider<MatriculaModalidadeNotifier,
    AsyncValue<List<MatriculaModalidadesModel>>>(
  (ref) {
    //final supabase = Supabase.instance.client;
    // final modalidadesRepository = ModalidadesRepository();
    return MatriculaModalidadeNotifier(ref.read(modalidadeUsecaseProvider));
  },
);
final matriculaModalidadeProvider = StateProvider<int?>((ref) => null);
