import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/matricula_modalidades_model.dart';

class ModalidadesRepository {
  final _supabase = Supabase.instance.client;

  Future<List<ModalidadesModel>> buscarModalidade() async {
    await buscar();
    final response = await _supabase.from('modalidades').select();
    return response.map<ModalidadesModel>((json) {
      debugPrint(json.toString());
      return ModalidadesModel.fromJson(json);
    }).toList();
  }

  buscar() async {
    final response = await _supabase
        .from('matricula_modalidade')
        .select('id, matriculas(alunos(nome)), modalidades(nome)');
    return response.map<MatriculaModalidadesModel>(
      (json) {
        debugPrint('teste: ${json.toString()}');
        return MatriculaModalidadesModel.teste(
            matriculaId: json['id'],
            // modalidadeId: json['modalidade_id'],
            idAluno: json['matricula_id']);
      },
    ).toList();
  }
}
