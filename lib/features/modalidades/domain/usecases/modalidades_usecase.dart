import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';

class ModalidadesUsecase {
  final ModalidadesRepository _repository;
  ModalidadesUsecase(this._repository);

  Future<List<ModalidadesModel>> buscarModalidade() {
    return _repository.buscarModalidade();
  }

  buscarMatriculaModalidade() {
    return _repository.buscarMatriculaModalidade();
  }

  buscarMatriculaModalidadeFiltro(int id) {
    return _repository.buscarMatriculaModalidadeFiltro(id);
  }

  deletarMatriculaModalidade(int id) {
    return _repository.deletarMatriculaModalidade(id);
  }
}
