import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';

class AlunoService {
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
