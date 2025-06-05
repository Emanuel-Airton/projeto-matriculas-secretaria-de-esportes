import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/services/matricula_modalidade_sevices.dart';

class ModalidadesUsecase {
  final ModalidadesRepository _repository;
  ModalidadesUsecase(this._repository);

  Future<List<ModalidadesModel>> buscarListaModalidade() {
    return _repository.buscarListaModalidade();
  }

  Future<ModalidadesModel> buscarModalidade(int idModalidade) {
    return _repository.buscarModalidade(idModalidade);
  }

  buscarMatriculaModalidade() {
    return _repository.buscarMatriculaModalidade();
  }

  buscarMatriculaModalidadeFiltro(int id) {
    return _repository.buscarMatriculaModalidadeFiltro(id);
  }

  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadePnomeAluno(
      String nomeAluno,
      {int? idModalidade}) {
    MatriculaModalidadeSevices matriculaModalidadeSevices =
        MatriculaModalidadeSevices(_repository);
    return matriculaModalidadeSevices.buscarMatriculaModalidadePnomeAluno(
        nomeAluno,
        idModalidade: idModalidade);
  }

  deletarMatriculaModalidade(int id) {
    return _repository.deletarMatriculaModalidade(id);
  }
}
