import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/services/matricula_modalidade_sevices.dart';
import '../models/matricula_modalidades_model.dart';

class ModalidadesRepository {
  final MatriculaModalidadeSevices _matriculaModalidadeSevices;
  final AlunoRepository _alunoRepository;
  ModalidadesRepository(
      this._matriculaModalidadeSevices, this._alunoRepository);

  Future<ModalidadesModel> buscarModalidade(int id) async {
    return _matriculaModalidadeSevices.buscarModalidade(id);
  }

  Future<List<ModalidadesModel>> buscarListaModalidade() async {
    return _matriculaModalidadeSevices.buscarListaModalidade();
  }

  //retorna a lista de todas as matriculas de acordo com o ID da modalidade
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadeFiltro(
      int id) async {
    return _matriculaModalidadeSevices.buscarMatriculaModalidadeFiltro(id);
  }

  //retorna a lista de todas as matriculas
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidade() async {
    return _matriculaModalidadeSevices.buscarMatriculaModalidade();
  }

  //Busca as matriculas de acordo com o nome digitado
  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadePnomeAluno(
      String nomeAluno,
      {int? idModalidade}) async {
    List<Map<String, dynamic>> response = [];
    final idsAlunos = await _alunoRepository.buscarListAlunosPorNome(nomeAluno);
    if (idModalidade != null) {
      response = await _matriculaModalidadeSevices.buscarComIdModalidade(
          nomeAluno, idModalidade, idsAlunos);
    } else {
      response = await _matriculaModalidadeSevices.buscarSemIdModalidade(
          nomeAluno, idsAlunos);
    }
    return response.map<MatriculaModalidadesModel>((json) {
      return MatriculaModalidadesModel.fromJson(json);
    }).toList();
  }

  deletarMatriculaModalidade(int id) async {
    return _matriculaModalidadeSevices.deletarMatriculaModalidade(id);
  }
}
