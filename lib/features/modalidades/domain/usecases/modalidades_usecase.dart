import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';

class ModalidadesUsecase {
  final ModalidadesRepository _repository;
  ModalidadesUsecase(this._repository);

  Future<List<ModalidadesModel>> buscarModalidade() {
    return _repository.buscarModalidade();
  }
}
