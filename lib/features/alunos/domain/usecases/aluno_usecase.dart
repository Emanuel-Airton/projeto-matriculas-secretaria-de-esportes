import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';

class AlunoUseCase {
  final AlunoRepository _repository;

  AlunoUseCase(this._repository);

  Future<List<AlunoModel>> buscarAlunos() {
    return _repository.buscarAlunos();
  }

  List<AlunoModel> buscarLista() {
    return _repository.listAunoModel;
  }

  /*Stream<List<AlunoModel>> setupRealTime() {
    return _repository.watchAluno();
  }*/

  Future<List<AlunoModel>> buscarAlunoNome(String nome) {
    return _repository.buscarAlunoPNome(nome);
  }

  Stream<List<AlunoModel>> buscarAlunosListen(int count) {
    return _repository.buscarAlunosListen(count);
  }

  Future<AlunoModel> cadastrarAluno(AlunoModel aluno) {
    return _repository.cadastrarAluno(aluno);
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) {
    return _repository.atualizarAluno(alunoId, json);
  }

  Future deletarAluno(int alunoId) {
    return _repository.deletarAluno(alunoId);
  }

  Stream<List<AlunoModel>> buscarAlunoPorNomeStream(String nomeAluno) {
    return _repository.buscarAlunoPorNomeStream(nomeAluno);
  }

  buscarListAlunosPorNome(String nomeAluno) {
    return _repository.buscarListAlunosPorNome(nomeAluno);
  }

  Future<List<AlunoModel>> buscarAlunoPNome(String nomeAluno) {
    return _repository.buscarAlunoPNome(nomeAluno);
  }
}
