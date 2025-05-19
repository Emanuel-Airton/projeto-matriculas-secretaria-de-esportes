import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class GeneratedPdfListaMatriculas {
  Future carregarImagem() async {
    final image = await rootBundle.load('assets/images/logo.jpeg');
    final imageByte = image.buffer.asUint8List();
    pw.Image imagem = pw.Image(pw.MemoryImage(imageByte), height: 100);
    return imagem;
  }

  bool multipage = false;
  Future<Uint8List> gerarPdfListaMatriculas(
      List<MatriculaModalidadesModel> listaMatricula) async {
    final pdf = pw.Document();
    pw.Image image = await carregarImagem();
    const totalItens = 25;
    //verifica se a lista tem mais que 25 itens, se tiver, adiciona uma nova pagina
    if (listaMatricula.length > totalItens) {
      double indice = (listaMatricula.length) / totalItens;
      int valor = indice.toInt();
      for (int indiceLista = 0; indiceLista <= valor; indiceLista++) {
        pdf.addPage(pw.MultiPage(
          margin: pw.EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 15),
          build: (context) {
            return [
              pw.Column(children: [
                pw.Center(child: image),
                criarTabelaLinha(listaMatricula, indiceLista),
              ])
            ];
          },
        ));
      }
    } else {
      pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 15),
        build: (context) {
          return pw.Column(children: [
            pw.Center(child: image),

            criarTabelaLinha(listaMatricula, 0),
            //  criarTabelaLinha(listaMatricula, 1)
          ]);
        },
      ));
    }

    return pdf.save();
  }

  pw.Widget criarTabelaLinha(
      List<MatriculaModalidadesModel> listaMatricula, int pageIndex) {
    final itemsPerPage = 25;
    final start = pageIndex * itemsPerPage;
    final end = min((pageIndex + 1) * itemsPerPage, listaMatricula.length);

    return pw.Column(children: [
      pw.Center(
          child: pw.Text('Lista de alunos matriculados',
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14))),
      pw.SizedBox(height: 15),
      pw.Table.fromTextArray(
        border: pw.TableBorder.all(width: 1),
        cellAlignment: pw.Alignment.center,
        headerPadding: pw.EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 2),
        headerStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
        data: listaMatricula
            .sublist(start, end)
            .map((e) => [
                  e.id.toString(),
                  e.modalidadeNome,
                  e.aluno!.nome,
                  DateFormat('dd/MM/yyyy').format(e.dataMatricula!)
                ])
            .toList(),
        headers: ['Nº matricula', 'Modalidade', 'Aluno', 'Data de matricula'],
        cellPadding: const pw.EdgeInsets.all(4),
      )
    ]);
  }
}
