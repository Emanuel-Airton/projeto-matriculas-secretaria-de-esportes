class ModalidadesModel {
  int? id;
  String? nome;

  ModalidadesModel({required this.id, required this.nome});

  factory ModalidadesModel.fromJson(Map<String, dynamic> json) {
    return ModalidadesModel(id: json['id'], nome: json['nome']);
  }
}
