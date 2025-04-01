class UserModel {
  String? id;
  String? email;

  UserModel.semDados();
  UserModel({
    required this.id,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
    );
  }
}
