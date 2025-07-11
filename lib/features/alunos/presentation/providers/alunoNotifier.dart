import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import '../../data/models/aluno_model.dart';
import '../../domain/usecases/aluno_usecase.dart';

class AlunoNotifier extends StateNotifier<AsyncValue<List<AlunoModel>>> {
  final AlunoUseCase _alunoUseCase;
  List<AlunoModel> _cache = <AlunoModel>[];
  Timer? timer;
  AlunoNotifier(this._alunoUseCase) : super(AsyncValue.data([])) {
    _fetchAlunos();
  }

  _fetchAlunos({bool forcedDelay = false}) async {
    state = AsyncValue.loading();
    try {
      if (_cache.isNotEmpty && !forcedDelay) {
        state = AsyncValue.data(_cache);
        return;
      }
      buscarAlunosSalvarCache();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  buscarAlunosSalvarCache() async {
    await Future.delayed(Duration(milliseconds: 500));
    Result result = await _alunoUseCase.buscarAlunos();
    switch (result) {
      case Ok _:
        _cache = result.value;
        state = AsyncValue.data(_cache);
        break;
      case Error _:
        state = AsyncValue.error(result.error, StackTrace.current);
    }
  }

  Future<Result> deletarAluno(int alunoId) async {
    Result result = await _alunoUseCase.deletarAluno(alunoId);
    switch (result) {
      case Ok():
        _cache = _cache.where((element) => element.id != alunoId).toList();
        state = AsyncValue.data(_cache);
        timer = Timer(const Duration(milliseconds: 5000), () => _fetchAlunos());
      case Error():
        Result.error(Exception(result.error));
    }
    return result;
  }

  Future<Result> cadastrarAluno(AlunoModel alunoModel) async {
    Result<AlunoModel> result = await _alunoUseCase.cadastrarAluno(alunoModel);
    switch (result) {
      case Ok():
        _cache = [..._cache, result.value];
        state = AsyncValue.data(_cache);
        _fetchAlunos(forcedDelay: true);
      case Error():
        _fetchAlunos();
        Result.error(Exception(result.error));
    }
    return result;
  }

  Future<Result> atualizarDadosAlunos(
      int alunoId, Map<String, dynamic> json) async {
    Result<AlunoModel> result =
        await _alunoUseCase.atualizarAluno(alunoId, json);
    switch (result) {
      case Ok<AlunoModel>():
        _cache = _cache
            .map((element) => element.id == alunoId ? result.value : element)
            .toList();
        state = AsyncValue.data(_cache);
        _fetchAlunos(forcedDelay: true);

      case Error():
        _fetchAlunos();
        Result.error(Exception(result.error));
    }
    return result;
  }

  buscarAlunoPorNome(String nome) async {
    Result result = await _alunoUseCase.buscarAlunoPNome(nome);
    Exception exception;
    switch (result) {
      case Ok _:
        _cache = result.value;
        state = AsyncValue.data(_cache);
        if (state.value!.isEmpty) {
          exception = Exception('Aluno não encontrado!');
          state = AsyncValue.error(exception, StackTrace.current);
        }
      case Error _:
        exception = result.error;
        state = AsyncValue.error(exception, StackTrace.current);
    }
  }
}

final alunoNotifierProvider =
    StateNotifierProvider<AlunoNotifier, AsyncValue<List<AlunoModel>>>((ref) {
  final alunoUseCase = ref.read(alunoUseCaseProvider);
  return AlunoNotifier(alunoUseCase);
});
final nomeAlunoProvider = StateProvider<String>((ref) => '');
