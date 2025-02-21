class MatriculaModel {
  final int? id;
  String? nomeAluno;
  String? nomeProjeto;
  DateTime? dataMatricula;
  int? idAluno;
  int? idProjeto;

  // Construtor para cadastrar uma nova matrícula (envia ID do aluno e projeto)
  MatriculaModel.cadastrarDados(
      {this.id,
      required this.idAluno,
      required this.idProjeto,
      required this.dataMatricula});
  // Construtor para recuperar matrícula (exibe nome do aluno e projeto)
  MatriculaModel.recuperarDados(
      {this.id,
      required this.nomeAluno,
      required this.nomeProjeto,
      required this.dataMatricula});

// Converte JSON para MatriculaModel
  factory MatriculaModel.fromJson(Map<String, dynamic> json) {
    return MatriculaModel.recuperarDados(
        id: json['id'],
        nomeAluno: json['alunos']['nome'],
        nomeProjeto: json['projetos']['nome'],
        dataMatricula: DateTime.parse(json['data_matricula']));
  }
  // Converte um objeto MatriculaModel para JSON (para cadastrar)
  Map<String, dynamic> toJson() {
    return {
      'aluno_id': idAluno,
      'projeto_id': idProjeto,
      //'data_matricula': dataMatricula?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }
}
