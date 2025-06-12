import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import '../../../core/utils/generate_pdf.dart';
import '../../../domain/usecases/generate_pdf_usecase.dart';

class AlertdialogPdfpreview extends StatelessWidget {
  final AlunoModel alunoModel;
  final GeneratePdfUsecase _generatePdfUsecase;
  AlertdialogPdfpreview({super.key, required this.alunoModel})
      : _generatePdfUsecase = GeneratePdfUsecase(GeneratePdf());
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: FutureBuilder<Uint8List>(
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
          future: _generatePdfUsecase(alunoModel),
        ),
      ),
    );
  }
}
