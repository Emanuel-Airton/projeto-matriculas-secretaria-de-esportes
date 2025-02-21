class MatriculaModalidadesModel {
  int? matriculaId;
  int? modalidadeId;
  int? idAluno;
  MatriculaModalidadesModel({
    required this.matriculaId,
    required this.modalidadeId,
  });
  MatriculaModalidadesModel.teste(
      {required this.matriculaId,
      //  required this.modalidadeId,
      required this.idAluno});
  factory MatriculaModalidadesModel.fromJson(Map<String, dynamic> json) {
    return MatriculaModalidadesModel.teste(
        matriculaId: json['id'],
        //  modalidadeId: json['matricula_id'],
        idAluno: json['matriculas']['aluno_id']);
  }
  Map<String, dynamic> toJson() {
    return {
      'matricula_id': matriculaId,
      'modalidade_id': modalidadeId,
    };
  }
}
