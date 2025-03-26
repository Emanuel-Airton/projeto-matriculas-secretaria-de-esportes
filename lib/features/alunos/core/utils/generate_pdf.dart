import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';

class GeneratePdf {
  Future carregarImagem() async {
    final image = await rootBundle.load('assets/images/logo.jpeg');
    final imageByte = image.buffer.asUint8List();
    pw.Image imagem = pw.Image(pw.MemoryImage(imageByte), height: 100);
    return imagem;
  }

  Future<Uint8List> gerarPdf(AlunoModel aluno) async {
    final dateFormat = DateFormat('dd/MM/yyyy').format(aluno.nascimento!);
    final pdf = pw.Document();

    pw.Image image = await carregarImagem();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Center(child: image),
              criarTabelaTitulo('ADOLESCENTE NOTA 10'),
              criarTabelaLinha('NOME DO ALUNO:', aluno.nome),
              criarTabelaLinhaDupla('GÊNERO:', aluno.sexo ?? '',
                  'DATA DE NASCIMENTO:', dateFormat ?? ''),
              criarTabelaLinha('TELEFONE:', aluno.telefone ?? ''),
              criarTabelaLinha('ENDEREÇO:', aluno.endereco ?? ''),
              criarTabelaLinha('ESCOLA QUE ESTUDA:', aluno.escola ?? ''),
              criarTabelaLinha('NOME DA MÃE:', aluno.nomeMae ?? ''),
              criarTabelaLinhaDupla(
                  'RG:', aluno.rgMae ?? '', 'CPF:', aluno.cpfMae ?? ''),
              criarTabelaLinha(
                  'POSTO DE SAÚDE DA FAMÍLIA:', aluno.postoSaude ?? ''),
              criarTabelaLinha('ASSINATURA DO RESPONSÁVEL:', ''),
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
