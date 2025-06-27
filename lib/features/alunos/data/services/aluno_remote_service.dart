import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlunoRemoteService {
  final SupabaseClient _supabase;
  AlunoRemoteService(this._supabase);

  Future<List<AlunoModel>> buscarAlunos() async {
    final response =
        await _supabase.from('alunos').select().order('nome', ascending: true);
    return response
        .map<AlunoModel>((json) => AlunoModel.fromJson(json))
        .toList();
  }

  Future<List<AlunoModel>> buscarAlunoPNome(String nome) async {
    final response = await _supabase
        .from('alunos')
        .select()
        .like('nome', '%$nome%')
        .order('id', ascending: true);
    return response
        .map<AlunoModel>((json) => AlunoModel.fromJson(json))
        .toList();
  }

  Stream<List<AlunoModel>> buscarAlunosListen(int count) {
    return _supabase
        .from('alunos')
        .stream(primaryKey: ['id']) // Define a chave primária
        .limit(count) //define um limite de intens por consulta
        .order('id', ascending: true) // Ordena por ID
        .map((data) =>
            data.map<AlunoModel>((json) => AlunoModel.fromJson(json)).toList());
  }

  Stream<List<AlunoModel>> buscarAlunoPorNomeStream(String nome) {
    return _supabase
        .from('alunos')
        .stream(primaryKey: ['id'])
        .eq('nome', nome)
        .order('id', ascending: true)
        .map((data) =>
            data.map<AlunoModel>((json) => AlunoModel.fromJson(json)).toList());
  }

  Future<List<dynamic>> buscarListAlunosPorNome(String nomeAluno) async {
    final response = await _supabase
        .from('alunos')
        .select('id')
        .like('nome', '%$nomeAluno%');
    if (response.isEmpty) return [];
    return response.map((e) => e['id']).toList();
  }

  Future<AlunoModel> cadastrarAluno(AlunoModel aluno) async {
    await _supabase.from('alunos').insert(aluno.toJson());
    return aluno;
  }

  Future<void> atualizarAluno(int alunoId, Map<String, dynamic> json) async {
    await _supabase.from('alunos').update(json).eq('id', alunoId);
  }

  Future<void> deletarAluno(int alunoId) async {
    await _supabase.from('alunos').delete().eq('id', alunoId);
  }

  //recebe a lista completa de alunos e separa a quantidade de acordo com o sexo
  Future<Map<String, dynamic>> quantidadeAlunoPorGenero(
      List<AlunoModel> listAlunoModel) async {
    List listMasculino = [];
    List listFeminino = [];

    for (int index = 0; index < listAlunoModel.length; index++) {
      if (listAlunoModel[index].sexo == 'masculino') {
        listMasculino.add(listAlunoModel[index]);
      } else {
        listFeminino.add(listAlunoModel[index]);
      }
    }
    return {
      'total': listAlunoModel.length,
      'masculino': listMasculino.length,
      'feminino': listFeminino.length
    };
  }
}
