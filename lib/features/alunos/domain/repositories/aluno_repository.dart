import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

abstract class AlunoRepository {
  Future<Result<List<AlunoModel>>> buscarAlunos();
  Future<Result<List<AlunoModel>>> buscarAlunoPNome(String nome);
  Future<Result<List<dynamic>>> retornaIdListAlunos(String nomeAluno);
  Future<Result<AlunoModel>> cadastrarAluno(AlunoModel aluno);
  Future<Result<AlunoModel>> atualizarAluno(
      int alunoId, Map<String, dynamic> json);
  Future<Result<void>> deletarAluno(int alunoId);
}
