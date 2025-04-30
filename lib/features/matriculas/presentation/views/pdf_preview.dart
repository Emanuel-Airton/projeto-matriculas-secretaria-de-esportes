import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/core/utils/generated_pdf.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/domain/usecases/GeneratePdfUsecase.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class Pdfpreview extends StatelessWidget {
  final MatriculaModalidadesModel matriculaModel;
  final Generatepdfusecase _generatepdfusecase;
  Pdfpreview({super.key, required this.matriculaModel})
      : _generatepdfusecase = Generatepdfusecase(GeneratedPdf());
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: FutureBuilder<Uint8List>(
          future: _generatepdfusecase(matriculaModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Erro ao gerar PDF.'));
            }
            return PdfPreview(
              shouldRepaint: false,
              canDebug: false,
              canChangeOrientation: false,
              canChangePageFormat: false,
              build: (format) async {
                bytes = snapshot.data;
                return bytes!;
              },
              actions: [],
            );
          },
        ),
      ),
    );
  }
}
