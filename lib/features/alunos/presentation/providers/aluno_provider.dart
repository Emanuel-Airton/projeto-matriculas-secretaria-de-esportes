import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/domain/usecases/aluno_usecase.dart';

// Criar o repositório e use case como providers
final alunoRepositoryProvider = Provider((ref) => AlunoRepository());
final alunoUseCaseProvider =
    Provider((ref) => AlunoUseCase(ref.read(alunoRepositoryProvider)));

// Estado dos alunos
final alunoListProvider = FutureProvider<List<AlunoModel>>((ref) {
  final contador = ref.watch(count);
  return ref.read(alunoUseCaseProvider).buscarAlunos();
});

/*final alunoListProviderListen = StreamProvider<List<AlunoModel?>>((ref) {
  final contador = ref.watch(count);
  final nome = ref.watch(nomeAluno);
  if (contador != null) {
    if (nome != '') {
      return ref.watch(alunoUseCaseProvider).buscarAlunoPorNome(nome!);
    }
    return ref.watch(alunoUseCaseProvider).buscarAlunosListen(contador);
  }
  return ref.watch(alunoUseCaseProvider).buscarAlunosListen(contador!);
});*/
final pegarLista = StateProvider<List<AlunoModel>>(
  (ref) {
    return ref.watch(alunoUseCaseProvider).buscarLista();
  },
);

final setupRealTime = FutureProvider<List<AlunoModel?>>(
  (ref) async {
    /* ref.watch(pegarLista.notifier).state =
        await ref.watch(alunoUseCaseProvider).setupRealTime();*/
    return ref.watch(alunoUseCaseProvider).setupRealTime();
  },
);
final count = StateProvider<int?>((ref) => 20);
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
