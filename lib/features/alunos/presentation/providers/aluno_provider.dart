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
  return ref.read(alunoUseCaseProvider).buscarAlunos();
});

final count = StateProvider<int?>((ref) => 2);
final countListenable = Provider((ref) => ref.read(count));
final alunoListProviderListen = StreamProvider<List<AlunoModel?>>((ref) {
  final contador = ref.watch(count);
  if (contador != null) {
    return ref.watch(alunoUseCaseProvider).buscarAlunosListen(contador);
  }
  return ref.watch(alunoUseCaseProvider).buscarAlunosListen(contador!);
});

final cadastrarAlunoProvider = ((ref) {
  return ref.read(alunoUseCaseProvider).cadastrarAluno();
});
