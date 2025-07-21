import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository_impl.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/modalidades_provider.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class MatriculaModalidadeNotifier
    extends StateNotifier<AsyncValue<List<MatriculaModalidadesModel>>> {
  final ModalidadesRepositoryImpl _modalidadesRepository;
  List<MatriculaModalidadesModel> cache = [];
  Timer? _timer;
  dynamic _result;
  MatriculaModalidadeNotifier(this._modalidadesRepository)
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
    await Future.delayed(Duration(milliseconds: 500));
    _result = await _modalidadesRepository.buscarMatriculaModalidade();

    if (_result is Ok) {
      cache = _result?.value;
      state = AsyncValue.data(cache);
    }
    if (_result is Error) {
      debugPrint(_result.error.toString());
      state = AsyncValue.error(_result.error, StackTrace.current);
    }
  }

//classe statenotifier
  deletarMatriculaModalidade(int idMatriculaModalidade,
      {int? idModalidade}) async {
    final Result result = await _modalidadesRepository
        .deletarMatriculaModalidade(idMatriculaModalidade);
    switch (result) {
      case Ok _:
        cache = cache
            .where((matricula) => matricula.id != idMatriculaModalidade)
            .toList();
        state = AsyncValue.data(cache);
        _timer = Timer(
            Duration(milliseconds: 500),
            () => fetchMatriculasModalidade(
                forcarBusca: true, idModalidade: idModalidade));
        break;
      case Error _:
        debugPrint(result.error.toString());
        state = AsyncValue.error(result.error, StackTrace.current);
    }
    return result;
  }

  buscarMatriculaModalidadePnomeAluno(String nomeAluno,
      {int? idModalidade}) async {
    state = AsyncValue.loading();
    await Future.delayed(Duration(milliseconds: 500));
    debugPrint('id: ${idModalidade.toString()}');
    _result = await _modalidadesRepository.buscarMatriculaModalidadePnomeAluno(
        nomeAluno,
        idModalidade: idModalidade);
    debugPrint(_result.toString());

    switch (_result) {
      case Ok _:
        debugPrint(_result.toString());
        cache = _result.value;
        state = AsyncValue.data(cache);
        break;
      case Error _:
        debugPrint('ERRO: ${_result.error.toString()}');
        state = AsyncValue.error(_result.error, StackTrace.current);
        break;
    }
  }

  _buscarMatriculasModalidadeFiltro(int id) async {
    state = AsyncValue.loading();
    await Future.delayed(Duration(milliseconds: 500));
    _result = await _modalidadesRepository.buscarMatriculaModalidadeFiltro(id);
    switch (_result) {
      case Ok _:
        cache = _result.value;
        state = AsyncValue.data(cache);
        break;
      case Error _:
        debugPrint(_result.error.toString());
        state = AsyncValue.error(_result.error, StackTrace.current);
        break;
    }
  }
}

final matriculaModalidade = StateNotifierProvider<MatriculaModalidadeNotifier,
    AsyncValue<List<MatriculaModalidadesModel>>>(
  (ref) {
    return MatriculaModalidadeNotifier(ref.read(modalidadeRepository));
  },
);
//final matriculaModalidadeProvider = StateProvider<int?>((ref) => null);
