import 'package:projeto_secretaria_de_esportes/features/matriculas/data/models/matricula_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatriculaRepository {
  final _supaBase = Supabase.instance.client;
  static const String tabelaMatricula = 'matriculas';

  //buscar matriculas no banco
  Future<List<MatriculaModel>> buscarMatricula() async {
    final response = await _supaBase
        .from(tabelaMatricula)
        .select('id, data_matricula, alunos(nome), projetos(nome)');
    return response
        .map<MatriculaModel>((json) => MatriculaModel.fromJson(json))
        .toList();
  }

  //cadastrar uma nova matricula
/*  Future<void> cadastrarMatricula(MatriculaModel matriculaModel) async {
    await _supaBase.from(tabelaMatricula).insert(matriculaModel.toJson());
  }
*/
  /* Future<void> cadastrarMatriculaComModalidades(
      MatriculaModel matriculaModel, List<int> modalidades) async {
    //Criar a matrícula
    final response = await _supaBase
        .from(tabelaMatricula)
        .insert(matriculaModel.toJson())
        .select()
        .single();
    final int matriculaId = response['id'];

    //Cadastrar as modalidades escolhidas
    final List<Map<String, dynamic>> modalidadesData = modalidades.map(
      (modalidadeId) {
        return MatriculaModalidadesModel(
                matriculaId: matriculaId, modalidadeId: modalidadeId)
            .toJson();
      },
    ).toList();
    await _supaBase.from('matricula_modalidade').insert(modalidadesData);
  }*/
  Future<void> cadastrarMatriculaComModalidades(
      int alunoId, List<int> modalidades) async {
    //Criar a matrícula

    //Cadastrar as modalidades escolhidas
    final List<Map<String, dynamic>> modalidadesData = modalidades.map(
      (modalidadeId) {
        return MatriculaModalidadesModel(
                alunoId: alunoId, modalidadeId: modalidadeId)
            .toJson();
      },
    ).toList();
    await _supaBase.from('matricula_modalidade').insert(modalidadesData);
  }
}
