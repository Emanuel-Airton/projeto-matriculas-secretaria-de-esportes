import '../../../alunos/data/models/aluno_model.dart';

class MatriculaModalidadesModel {
  int? matriculaId;
  String? modalidadeNome;
  // String? nomeAluno;
  // int? idAluno;
  int? modalidadeId;
  AlunoModel? aluno; // Instância de AlunoModel

  MatriculaModalidadesModel(
      {required this.matriculaId, required this.modalidadeId, this.aluno});

  MatriculaModalidadesModel.teste({
    required this.matriculaId,
    required this.modalidadeNome,
    //  required this.nomeAluno,
    this.aluno,
  });

  factory MatriculaModalidadesModel.fromJson(Map<String, dynamic> json) {
    return MatriculaModalidadesModel.teste(
        matriculaId: json['id'],
        modalidadeNome: json['modalidades']['nome'],
        //   nomeAluno: json['matriculas']['alunos']['nome'],
        aluno:
            AlunoModel.fromJson(json['matriculas']['alunos'], DateTime.now()));
  }
  Map<String, dynamic> toJson() {
    return {
      'matricula_id': matriculaId,
      'modalidade_id': modalidadeId,
    };
  }
}
