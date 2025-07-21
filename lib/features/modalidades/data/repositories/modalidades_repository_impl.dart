import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository_impl.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/services/matricula_modalidade_sevices.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/domain/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';
import '../models/matricula_modalidades_model.dart';

class ModalidadesRepositoryImpl implements ModalidadesRepository {
  final MatriculaModalidadeSevices _matriculaModalidadeSevices;
  final AlunoRepositoryImpl _alunoRepository;
  ModalidadesRepositoryImpl(
      this._matriculaModalidadeSevices, this._alunoRepository);

  @override
  Future<Result<ModalidadesModel>> buscarModalidade(int id) async {
    final result = await _matriculaModalidadeSevices.buscarModalidade(id);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar modalidade'));
  }

  @override
  Future<Result<List<ModalidadesModel>>> buscarListaModalidade() async {
    final result = await _matriculaModalidadeSevices.buscarListaModalidade();
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao buscar lista de modalidade'));
  }

  //retorna a lista de todas as matriculas de acordo com o ID da modalidade
  @override
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidadeFiltro(int id) async {
    final result =
        await _matriculaModalidadeSevices.buscarMatriculaModalidadeFiltro(id);
    if (result is Ok) return result;
    return Result.error(Exception('erro ao buscar lista'));
  }

  //retorna a lista de todas as matriculas
  @override
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidade() async {
    final result =
        await _matriculaModalidadeSevices.buscarMatriculaModalidade();
    if (result is Ok) return result;
    return Result.error(Exception('erro ao buscar lista'));
  }

  //Busca as matriculas de acordo com o nome digitado
  @override
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidadePnomeAluno(String nomeAluno,
          {int? idModalidade}) async {
    final Result<List<MatriculaModalidadesModel>> result;
    Result resultIdsAlunos =
        await _alunoRepository.retornaIdListAlunos(nomeAluno);
    switch (resultIdsAlunos) {
      case Ok _:
        if (idModalidade != null) {
          result = await _matriculaModalidadeSevices.buscarComIdModalidade(
              nomeAluno, idModalidade, resultIdsAlunos.value);
        } else {
          result = await _matriculaModalidadeSevices.buscarSemIdModalidade(
              nomeAluno, resultIdsAlunos.value);
        }
        if (result is Ok) {
          return result;
        } else {
          return Result.error(Exception('Erro ao buscar matricula do aluno'));
        }
      case Error _:
        return Result.error(Exception(resultIdsAlunos.error));
    }
  }

  @override
  Future<Result> deletarMatriculaModalidade(int id) async {
    final result =
        await _matriculaModalidadeSevices.deletarMatriculaModalidade(id);
    if (result is Ok) return result;
    return Result.error(Exception('Erro ao excluir matricula'));
  }
}
