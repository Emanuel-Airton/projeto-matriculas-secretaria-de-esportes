import 'package:projeto_secretaria_de_esportes/features/matriculas/data/models/matricula_model.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/data/repositories/matricula_repository.dart';

class MatriculaUsecase {
  final MatriculaRepository _repository;

  MatriculaUsecase(this._repository);

  Future<List<MatriculaModel>> buscarMatriculas() {
    return _repository.buscarMatricula();
  }

  Future<void> cadastrarMatricula(MatriculaModel matriculaModel) {
    return _repository.cadastrarMatricula(matriculaModel);
  }

  Future<void> cadastrarMatriculaComModalidades(
      MatriculaModel matriculaModel, List<int> modalidades) {
    return _repository.cadastrarMatriculaComModalidades(
        matriculaModel, modalidades);
  }
}
