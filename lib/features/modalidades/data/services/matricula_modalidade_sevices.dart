import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';

class MatriculaModalidadeSevices {
  ModalidadesRepository _modalidadesRepository;
  MatriculaModalidadeSevices(this._modalidadesRepository);

  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadePnomeAluno(
      String nomeAluno,
      {int? idModalidade}) async {
    List<Map<String, dynamic>> response = [];
    final idsAlunos = await _modalidadesRepository.buscarIdsAlunos(nomeAluno);
    if (idModalidade != null) {
      debugPrint('buscarComIdModalidade');
      response = await _modalidadesRepository.buscarComIdModalidade(
          nomeAluno, idModalidade, idsAlunos);
    } else {
      debugPrint('buscarSemIdModalidade');
      response = await _modalidadesRepository.buscarSemIdModalidade(
          nomeAluno, idsAlunos);
    }
    return response.map<MatriculaModalidadesModel>((json) {
      return MatriculaModalidadesModel.fromJson(json);
    }).toList();
  }
}
