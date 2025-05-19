import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/core/utils/generated_pdf_lista_matriculas.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/domain/usecases/generated_pdf_lista_matriculas_usecase.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class PdfPreviewListaMatriculas extends StatelessWidget {
  final GeneratedPdfListaMatriculasUsecase generatedPdfListaMatriculasUsecase;
  final List<MatriculaModalidadesModel> listMatriculasModalidade;
  PdfPreviewListaMatriculas({super.key, required this.listMatriculasModalidade})
      : generatedPdfListaMatriculasUsecase =
            GeneratedPdfListaMatriculasUsecase(GeneratedPdfListaMatriculas());
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: FutureBuilder<Uint8List>(
            future: generatedPdfListaMatriculasUsecase
                .geraPdfListaMatriculas(listMatriculasModalidade),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Erro ao gerar PDF.'));
              }
              return PdfPreview(
                  shouldRepaint: false,
                  canDebug: false,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  dynamicLayout: true,
                  maxPageWidth: double.infinity,
                  enableScrollToPage: true,

                  //pdfFileName: 'doc.pdf',
                  build: (format) async {
                    bytes = snapshot.data;
                    return bytes!;
                  });
            }),
      ),
    );
  }
}
