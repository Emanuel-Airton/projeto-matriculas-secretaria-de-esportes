import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/views/pdf_preview.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_icons/simple_icons.dart';

class ContainerInfoMatricula extends StatefulWidget {
  MatriculaModalidadesModel matriculasModalidadesModel;
  ContainerInfoMatricula({super.key, required this.matriculasModalidadesModel});

  @override
  State<ContainerInfoMatricula> createState() => _ContainerInfoMatriculaState();
}

whatsAppLauncher(String telefone) async {
  var whatsappUrl = "https://api.whatsapp.com/send/?phone=$telefone";
  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {
    throw ('Não foi possível iniciar $whatsappUrl');
  }
}

class _ContainerInfoMatriculaState extends State<ContainerInfoMatricula> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.38,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Text(
                        'Data da matricula: ${DateFormat('dd/MM/yyyy').format(widget.matriculasModalidadesModel.dataMatricula!)}'),
                  ),
                  Tooltip(
                    message: 'Vizualizar matricula na modalidade',
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Pdfpreview(
                                  matriculaModel:
                                      widget.matriculasModalidadesModel);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.picture_as_pdf,
                          color: Colors.grey,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.white)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dados do aluno',
                      style: TextStyle(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'RG: ${widget.matriculasModalidadesModel.aluno!.rg.toString()}'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'CPF: ${widget.matriculasModalidadesModel.aluno!.cpf.toString()}'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'DATA DE NASCIMENTO: ${DateFormat('dd/MM/yyyy').format(widget.matriculasModalidadesModel.aluno!.nascimento!)}'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'Endereço: ${widget.matriculasModalidadesModel.aluno!.endereco.toString()}'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.15,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.white)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dados do responsável',
                      style: TextStyle(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Text(
                                  'Telefone: ${widget.matriculasModalidadesModel.aluno!.telefone.toString()}'),
                              IconButton(
                                  tooltip: 'Acessar WhatsApp',
                                  icon: Icon(SimpleIcons.whatsapp,
                                      size: MediaQuery.sizeOf(context).height *
                                          0.02,
                                      color: Colors.green),
                                  onPressed: () async {
                                    try {
                                      //formatando o numero de telefone
                                      String? telefoneFormatado = widget
                                          .matriculasModalidadesModel
                                          .aluno!
                                          .telefone
                                          ?.replaceAll(RegExp(r'\D'), '');
                                      await whatsAppLauncher(
                                          telefoneFormatado ?? '');
                                    } catch (erro) {
                                      debugPrint(erro.toString());
                                    }
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'Nome: ${widget.matriculasModalidadesModel.aluno!.nomeMae.toString()}'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'RG: ${widget.matriculasModalidadesModel.aluno!.rg.toString()}'),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Text(
                              'CPF: ${widget.matriculasModalidadesModel.aluno!.cpfMae.toString()}'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
