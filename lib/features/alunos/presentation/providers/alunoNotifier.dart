import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    final alunos = await _alunoUseCase.buscarAlunos();
    _cache = alunos;
    state = AsyncValue.data(alunos);
  }

  Future<void> deletarAluno(int alunoId) async {
    try {
      await _alunoUseCase.deletarAluno(alunoId);
      _cache = _cache.where((element) => element.id != alunoId).toList();
      state = AsyncValue.data(_cache);
      timer = Timer(const Duration(milliseconds: 5000), () => _fetchAlunos());
    } catch (e) {
      rethrow;
    }
  }

  cadastrarAluno(AlunoModel alunoModel) async {
    try {
      final aluno = await _alunoUseCase.cadastrarAluno(alunoModel);
      _cache = [..._cache, aluno];
      state = AsyncValue.data(_cache);
      _fetchAlunos(forcedDelay: true);
    } catch (e) {
      _fetchAlunos();
      debugPrint('erro: $e');
    }
  }

  buscarAlunoPorNome(String nome) async {
    try {
      _cache = await _alunoUseCase.buscarAlunoPNome(nome);
      state = AsyncValue.data(_cache);
      if (state.value!.isEmpty) {
        throw 'Aluno não encontrado!';
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final alunoNotifierProvider =
    StateNotifierProvider<AlunoNotifier, AsyncValue<List<AlunoModel>>>((ref) {
  //final supabase = Supabase.instance.client;
  final alunoRepository = AlunoRepository(Supabase.instance.client);
  final alunoUseCase = AlunoUseCase(alunoRepository);

  return AlunoNotifier(alunoUseCase);
});
final nomeAlunoProvider = StateProvider<String>((ref) => '');
