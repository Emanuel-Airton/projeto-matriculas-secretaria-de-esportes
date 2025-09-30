import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository_impl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/aluno_remote_service.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Criar o repositório e use case como providers

final alunoServices =
    Provider((ref) => AlunoRemoteService(Supabase.instance.client));
final alunoRepositoryProvider =
    Provider((ref) => AlunoRepositoryImpl(ref.read(alunoServices)));

// Estado dos alunos
final listAlunosProvider = StateProvider<List<AlunoModel>?>((ref) => []);

final quantidadeAlunos = StreamProvider<Map<String, dynamic>?>((ref) {
  final recuperaListAlunos = ref.watch(listAlunosProvider);
  if (recuperaListAlunos == null || recuperaListAlunos.isEmpty) {
    return Stream.value(null);
  }
  final streamController = StreamController<Map<String, dynamic>?>();

  Result result = ref
      .read(alunoRepositoryProvider)
      .quantidadeAlunoPorGenero(recuperaListAlunos);

  if (result is Ok) {
    streamController.add(result.value);
  } else if (result is Error) {
    streamController.addError(result.error);
  } else {
    streamController.addError(Exception('Erro desconhecido'));
  }

  return streamController.stream;
});

final count = StateProvider<int?>((ref) => 5);
final countListenable = Provider((ref) => ref.read(count));
final nomeAluno = StateProvider<String?>((ref) => '');

/*final alunoListProviderListen = FutureProvider<List<AlunoModel?>>((ref) async {
  final contador = ref.watch(count);
  final nome = ref.watch(nomeAluno);
  if (contador != null) {
    if (nome != '') {
      return ref.watch(alunoRepositoryProvider).buscarAlunoPNome(nome!);
    }
    return ref.watch(alunoRepositoryProvider).buscarAlunos();
  }
  return ref.watch(alunoRepositoryProvider).buscarAlunos();
});*/

final expandedStateProvider = StateProvider<Map<int, bool>>((ref) => {});

/*final streamListAlunos =
    StreamProvider((ref) => ref.watch(alunoServices).buscarAlunosListen());*/
