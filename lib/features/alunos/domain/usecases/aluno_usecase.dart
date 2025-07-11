import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';

class AlunoUseCase {
  final AlunoRepository _repository;

  AlunoUseCase(this._repository);

  buscarAlunos() {
    return _repository.buscarAlunos();
  }

  List<AlunoModel> buscarLista() {
    return _repository.listAunoModel;
  }

  /*Stream<List<AlunoModel>> setupRealTime() {
    return _repository.watchAluno();
  }*/

  buscarAlunoNome(String nome) {
    return _repository.buscarAlunoPNome(nome);
  }

  cadastrarAluno(AlunoModel aluno) {
    return _repository.cadastrarAluno(aluno);
  }

  atualizarAluno(int alunoId, Map<String, dynamic> json) {
    return _repository.atualizarAluno(alunoId, json);
  }

  Future deletarAluno(int alunoId) {
    return _repository.deletarAluno(alunoId);
  }

  retornaIdListAlunos(String nomeAluno) {
    return _repository.retornaIdListAlunos(nomeAluno);
  }

  buscarAlunoPNome(String nomeAluno) {
    return _repository.buscarAlunoPNome(nomeAluno);
  }
}
