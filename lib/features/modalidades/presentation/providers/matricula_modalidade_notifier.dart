import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/usecases/modalidades_usecase.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/modalidades_provider.dart';

class MatriculaModalidadeNotifier
    extends StateNotifier<AsyncValue<List<MatriculaModalidadesModel>>> {
  final ModalidadesUsecase _modalidadesUsecase;
  List<MatriculaModalidadesModel> cache = [];
  Timer? _timer;

  MatriculaModalidadeNotifier(this._modalidadesUsecase)
      : super(AsyncValue.data([])) {
    fetchMatriculasModalidade();
  }

  fetchMatriculasModalidade({bool forcarBusca = false, int? idModalidade}) {
    state = AsyncValue.loading();

    if (cache.isNotEmpty && !forcarBusca) {
      debugPrint('cache contem dados ${forcarBusca.toString()}');
      state = AsyncValue.data(cache);
      return;
    }
    if (idModalidade != null) {
      debugPrint('cache ${forcarBusca.toString()}');
      _buscarMatriculasModalidadeFiltro(idModalidade);
      return;
    } else {
      debugPrint('cache não contem dados ${forcarBusca.toString()}');
      _buscarMatriculasModalidade();
    }
  }

  _buscarMatriculasModalidade() async {
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
          () => fetchMatriculasModalidade(
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

  _buscarMatriculasModalidadeFiltro(int id) async {
    try {
      state = AsyncValue.loading();
      Future.delayed(Duration(milliseconds: 500));
      cache = await _modalidadesUsecase.buscarMatriculaModalidadeFiltro(id);
      state = AsyncValue.data(cache);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
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
//final matriculaModalidadeProvider = StateProvider<int?>((ref) => null);
