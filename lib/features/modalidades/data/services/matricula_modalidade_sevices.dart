import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/domain/usecases/aluno_usecase.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/repositories/modalidades_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatriculaModalidadeSevices {
  final ModalidadesRepository _modalidadesRepository;
  final AlunoRepository _alunoRepository;
  MatriculaModalidadeSevices(
      this._modalidadesRepository, this._alunoRepository);

  Future<List<MatriculaModalidadesModel>> buscarMatriculaModalidadePnomeAluno(
      String nomeAluno,
      {int? idModalidade}) async {
    List<Map<String, dynamic>> response = [];
    // final alunoRepository = AlunoRepository(Supabase.instance.client);
    //AlunoUseCase alunoUseCase = AlunoUseCase(alunoRepository);
    //  final idsAlunos = await alunoUseCase.buscarListAlunosPorNome(nomeAluno);
    final idsAlunos = await _alunoRepository.buscarListAlunosPorNome(nomeAluno);
    if (idModalidade != null) {
      // debugPrint('buscarComIdModalidade');
      response = await _modalidadesRepository.buscarComIdModalidade(
          nomeAluno, idModalidade, idsAlunos);
    } else {
      //debugPrint('buscarSemIdModalidade');
      response = await _modalidadesRepository.buscarSemIdModalidade(
          nomeAluno, idsAlunos);
    }
    return response.map<MatriculaModalidadesModel>((json) {
      return MatriculaModalidadesModel.fromJson(json);
    }).toList();
  }
}
