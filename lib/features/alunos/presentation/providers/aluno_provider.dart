import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/aluno_remote_service.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/domain/usecases/aluno_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Criar o repositório e use case como providers

final alunoServices =
    Provider((ref) => AlunoRemoteService(Supabase.instance.client));
final alunoRepositoryProvider =
    Provider((ref) => AlunoRepository(ref.read(alunoServices)));
final alunoUseCaseProvider =
    Provider((ref) => AlunoUseCase(ref.read(alunoRepositoryProvider)));
// Estado dos alunos

final listAlunosProvider = StateProvider<List<AlunoModel>?>((ref) => []);
final quantidadeAlunos = FutureProvider<Map<String, dynamic>?>((ref) async {
  Map<String, dynamic> map = {};
  final recuperaListAlunos = ref.watch(listAlunosProvider);
  if (recuperaListAlunos!.isNotEmpty) {
    map = await ref
        .read(alunoServices)
        .quantidadeAlunoPorGenero(recuperaListAlunos);
    debugPrint('map: ${map.toString()}');
  }
  return map;
});

final pegarLista = StateProvider<List<AlunoModel>>(
  (ref) {
    return ref.watch(alunoUseCaseProvider).buscarLista();
  },
);

final count = StateProvider<int?>((ref) => 5);
final countListenable = Provider((ref) => ref.read(count));
final nomeAluno = StateProvider<String?>((ref) => '');

final alunoListProviderListen = FutureProvider<List<AlunoModel?>>((ref) async {
  final contador = ref.watch(count);
  final nome = ref.watch(nomeAluno);
  if (contador != null) {
    if (nome != '') {
      return ref.watch(alunoUseCaseProvider).buscarAlunoNome(nome!);
    }
    return ref.watch(alunoUseCaseProvider).buscarAlunos();
  }
  return ref.watch(alunoUseCaseProvider).buscarAlunos();
});

final cadastrarAlunoProvider = ((ref) {
  return ref.read(alunoUseCaseProvider).cadastrarAluno();
});

final expandedStateProvider = StateProvider<Map<int, bool>>((ref) => {});

final streamListAlunos =
    StreamProvider((ref) => ref.watch(alunoServices).buscarAlunosListen());
