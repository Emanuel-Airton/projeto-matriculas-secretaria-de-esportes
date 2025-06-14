import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class GeneratedPdf {
  Future carregarImagem() async {
    final image = await rootBundle.load('assets/images/logo.jpeg');
    final imageByte = image.buffer.asUint8List();
    pw.Image imagem = pw.Image(pw.MemoryImage(imageByte), height: 100);
    return imagem;
  }

  Future<Uint8List> gerarPdf(MatriculaModalidadesModel matricula) async {
    final pdf = pw.Document();
    pw.Image image = await carregarImagem();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Center(child: image),
              criarTabelaTitulo('ADOLESCENTE NOTA 10'),
              criarTabelaLinha('NÚMERO DA MATRICULA:', matricula.id.toString()),
              criarTabelaLinha('MODALIDADE:', matricula.modalidadeNome ?? ''),
              criarTabelaLinha('NOME DO ALUNO:', matricula.aluno?.nome ?? ''),
              criarTabelaLinha(
                'DATA DA MATRICULA:',
                DateFormat('dd/MM/yyyy').format(matricula.dataMatricula!),
              ),
            ],
          );
        },
      ),
    );
    return await pdf.save();
  }

  pw.Widget criarTabelaTitulo(String titulo) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Center(
                child: pw.Text(
                  titulo,
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget criarTabelaLinha(String titulo, String valor) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [textRow(titulo, valor)],
        ),
      ],
    );
  }

  pw.Widget criarTabelaLinhaDupla(
      String titulo1, String valor1, String titulo2, String valor2) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            textRow(titulo1, valor1),
            textRow(titulo2, valor2),
          ],
        ),
      ],
    );
  }

  pw.Widget textRow(String text1, String text2) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Row(
        children: [
          pw.Text(text1, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(width: 5),
          pw.Text(text2),
        ],
      ),
    );
  }
}
