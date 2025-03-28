class AlunoModel {
  int? id;
  late String nome;
  String? sexo;
  String? telefone;
  String? cpf;
  DateTime? nascimento;
  String? rg;
  String? endereco;
  String? escola;
  String? turno;
  String? nomeMae;
  String? cpfMae;
  String? rgMae;
  String? postoSaude;
  String? fotoPerfilUrl;
  // double? renda;

  AlunoModel.semDados();
  AlunoModel({
    this.id,
    required this.nome,
    required this.sexo,
    required this.telefone,
    required this.nascimento,
    required this.rg,
    required this.cpf,
    required this.endereco,
    required this.escola,
    required this.turno,
    required this.nomeMae,
    required this.rgMae,
    required this.cpfMae,
    required this.postoSaude,
    this.fotoPerfilUrl,
    //required this.renda
  });
  AlunoModel.teste({required this.id, required this.nome});
  // Converte JSON para AlunoModel
  factory AlunoModel.fromJson(Map<String, dynamic> json) {
    // Verifica se o campo 'nascimento' é nulo antes de fazer o parsing
    DateTime? date;
    if (json['nascimento'] != null) {
      try {
        date = DateTime.parse(json['nascimento']);
      } catch (e) {
        // Em caso de erro no parsing, define como null
        date = null;
      }
    }

    return AlunoModel(
      id: json['id'],
      nome: json['nome'] ?? '', // Valor padrão para campos String
      sexo: json['sexo'] ?? '',
      telefone: json['telefone'] ?? '',
      nascimento: date, // Pode ser null
      rg: json['rg'] ?? '',
      cpf: json['cpf'] ?? '',
      endereco: json['endereço'] ?? '',
      escola: json['escola'] ?? '',
      turno: json['turno'] ?? '',
      nomeMae: json['nome_mae'] ?? '',
      rgMae: json['rg_mae'] ?? '',
      cpfMae: json['cpf_mae'] ?? '',
      postoSaude: json['posto_saude'] ?? '',
      fotoPerfilUrl: json['foto_perfil_url'] ?? '',
    );
  }

  // Converte AlunoModel para JSON
  Map<String, dynamic> toJson() {
    DateTime.timestamp();
    return {
      'nome': nome,
      'sexo': sexo,
      'telefone': telefone,
      'nascimento': nascimento?.toIso8601String(),
      'rg': rg,
      'cpf': cpf,
      'endereço': endereco,
      'escola': escola,
      'turno': turno,
      'nome_mae': nomeMae,
      'rg_mae': rgMae,
      'cpf_mae': cpf,
      'posto_saude': postoSaude,
      'foto_perfil_url': fotoPerfilUrl,
      //'renda': renda
    };
  }
}
