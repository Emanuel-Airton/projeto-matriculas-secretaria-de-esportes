import '../../../alunos/data/models/aluno_model.dart';

class MatriculaModalidadesModel {
  int? id;
  int? matriculaId;
  String? modalidadeNome;
  int? modalidadeId;
  AlunoModel? aluno; // Instância de AlunoModel
  DateTime? dataMatricula;

  MatriculaModalidadesModel(
      {required this.matriculaId, required this.modalidadeId, this.aluno});

  MatriculaModalidadesModel.teste({
    required this.id,
    required this.matriculaId,
    required this.modalidadeNome,
    this.dataMatricula,
    this.aluno,
  });

  factory MatriculaModalidadesModel.fromJson(Map<String, dynamic> json) {
    return MatriculaModalidadesModel.teste(
      id: json['id'],
      matriculaId: json['matricula_id'],
      dataMatricula: DateTime.parse(json['matriculas']['data_matricula']),
      modalidadeNome: json['modalidades']['nome'],
      aluno: AlunoModel.fromJson(json['matriculas']['alunos']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'matricula_id': matriculaId,
      'modalidade_id': modalidadeId,
    };
  }
}
