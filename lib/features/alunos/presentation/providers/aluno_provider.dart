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

final alunoListProviderListen = StreamProvider<List<AlunoModel>>((ref) {
  return ref.read(alunoUseCaseProvider).buscarAlunosListen();
});

final cadastrarAlunoProvider = ((ref) {
  return ref.read(alunoUseCaseProvider).cadastrarAluno();
});
