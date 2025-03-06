import 'dart:typed_data';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import '../../core/utils/generate_pdf.dart';

class GeneratePdfUsecase {
  final GeneratePdf _generatePdf;
  GeneratePdfUsecase(this._generatePdf);

  Future<Uint8List> call(AlunoModel alunoModel) async {
    return await _generatePdf.gerarPdf(alunoModel);
  }
}
