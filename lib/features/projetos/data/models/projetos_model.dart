class ProjetosModel {
  int? id;
  String? nome;

  ProjetosModel({this.id, this.nome});
  factory ProjetosModel.fromJson(Map<String, dynamic> json) {
    return ProjetosModel(id: json['id'], nome: json['nome']);
  }
}
