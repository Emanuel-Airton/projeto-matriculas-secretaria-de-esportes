import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';

class AlunoUseCase {
  final AlunoRepository _repository;

  AlunoUseCase(this._repository);

  Future<List<AlunoModel>> buscarAlunos() {
    return _repository.buscarAlunos();
  }

  Stream<List<AlunoModel>> buscarAlunosListen() {
    return _repository.buscarAlunosListen();
  }

  Future<void> cadastrarAluno(AlunoModel aluno) {
    return _repository.cadastrarAluno(aluno);
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) {
    return _repository.atualizarAluno(alunoId, json);
  }
}
