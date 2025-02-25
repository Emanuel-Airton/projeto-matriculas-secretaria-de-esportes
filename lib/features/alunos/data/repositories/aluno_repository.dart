import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlunoRepository {
  final _supabase = Supabase.instance.client;

  // Buscar todos os alunos
  Future<List<AlunoModel>> buscarAlunos() async {
    final response = await _supabase.from('alunos').select();
    return response.map<AlunoModel>((json) {
      //   final dateTime = DateTime.parse(json['nascimento'] ?? '');
      return AlunoModel.fromJson(json);
    }).toList();
  }

  // Cadastrar aluno
  Future<void> cadastrarAluno(AlunoModel aluno) async {
    await _supabase.from('alunos').insert(aluno.toJson());
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) async {
    await _supabase.from('alunos').update(json).eq('id', alunoId);
  }
}
