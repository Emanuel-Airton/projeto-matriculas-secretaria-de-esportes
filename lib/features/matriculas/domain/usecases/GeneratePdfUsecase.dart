import 'dart:typed_data';
import 'package:projeto_secretaria_de_esportes/features/matriculas/core/utils/generated_pdf.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class Generatepdfusecase {
  final GeneratedPdf _generatedPdf;
  Generatepdfusecase(this._generatedPdf);
  Future<Uint8List> call(MatriculaModalidadesModel matriculaModalidade) async {
    return await _generatedPdf.gerarPdf(matriculaModalidade);
  }
}
