import 'package:projeto_secretaria_de_esportes/features/matriculas/core/utils/generated_pdf_lista_matriculas.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class GeneratedPdfListaMatriculasUsecase {
  final GeneratedPdfListaMatriculas generatedPdfListaMatriculas;
  GeneratedPdfListaMatriculasUsecase(this.generatedPdfListaMatriculas);
  geraPdfListaMatriculas(List<MatriculaModalidadesModel> matriculasModalidade) {
    return generatedPdfListaMatriculas
        .gerarPdfListaMatriculas(matriculasModalidade);
  }
}
