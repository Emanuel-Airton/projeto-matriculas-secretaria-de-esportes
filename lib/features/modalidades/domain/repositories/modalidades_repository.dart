import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/utils/result.dart';

abstract class ModalidadesRepository {
  Future<Result<ModalidadesModel>> buscarModalidade(int id);
  Future<Result<List<ModalidadesModel>>> buscarListaModalidade();
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidadeFiltro(int id);
  Future<Result<List<MatriculaModalidadesModel>>> buscarMatriculaModalidade();
  Future<Result<List<MatriculaModalidadesModel>>>
      buscarMatriculaModalidadePnomeAluno(String nomeAluno,
          {int? idModalidade});
  Future<Result> deletarMatriculaModalidade(int id);
}
