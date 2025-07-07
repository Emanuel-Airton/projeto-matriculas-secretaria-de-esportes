import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/services/matricula_modalidade_sevices.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

class ModalidadesUsecase {
  final ModalidadesRepository _repository;

  ModalidadesUsecase(this._repository);

  //usecase
  buscarListaModalidade() {
    return _repository.buscarListaModalidade();
  }

  Future<Result<ModalidadesModel>> buscarModalidade(int idModalidade) {
    return _repository.buscarModalidade(idModalidade);
  }

  buscarMatriculaModalidade() {
    return _repository.buscarMatriculaModalidade();
  }

  buscarMatriculaModalidadeFiltro(int id) {
    return _repository.buscarMatriculaModalidadeFiltro(id);
  }

  buscarMatriculaModalidadePnomeAluno(String nomeAluno, {int? idModalidade}) {
    return _repository.buscarMatriculaModalidadePnomeAluno(nomeAluno,
        idModalidade: idModalidade);
  }

//classe usecase
  Future<Result> deletarMatriculaModalidade(int id) {
    return _repository.deletarMatriculaModalidade(id);
  }
}
