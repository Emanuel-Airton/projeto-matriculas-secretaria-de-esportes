import '../../../alunos/data/models/aluno_model.dart';

class MatriculaModalidadesModel {
  int? id;
  int? matriculaId;
  String? modalidadeNome;
  int? modalidadeId;
  int? alunoId;
  AlunoModel? aluno; // Instância de AlunoModel
  DateTime? dataMatricula;

  MatriculaModalidadesModel(
      {required this.alunoId, required this.modalidadeId, this.aluno});

  MatriculaModalidadesModel.teste({
    required this.id,
    required this.alunoId,
    required this.modalidadeNome,
    required this.dataMatricula,
    this.aluno,
  });

  factory MatriculaModalidadesModel.fromJson(Map<String, dynamic> json) {
    return MatriculaModalidadesModel.teste(
        id: json['id'],
        //  matriculaId: json['matricula_id'],
        alunoId: json['aluno_id'],
        //dataMatricula: DateTime.parse(json['matriculas']['data_matricula']),
        modalidadeNome: json['modalidades']['nome'],
        aluno: AlunoModel.fromJson(json['alunos']),
        dataMatricula: DateTime.parse(json['data_matricula']));
  }

  Map<String, dynamic> toJson() {
    return {
      'aluno_id': alunoId,
      'modalidade_id': modalidadeId,
    };
  }
}
