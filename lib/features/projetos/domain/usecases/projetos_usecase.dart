import 'package:projeto_secretaria_de_esportes/features/projetos/data/repository/projetos_repository.dart';

class ProjetosUsecase {
  final ProjetosRepository _projetosRepository;

  ProjetosUsecase(this._projetosRepository);

  buscarProjeto() {
    return _projetosRepository.buscarProjeto();
  }
}
