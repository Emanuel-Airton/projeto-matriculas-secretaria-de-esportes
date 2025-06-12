import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/core/utils/whatsApp_launcher.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/views/pdf_preview.dart';
import 'package:projeto_secretaria_de_esportes/features/matriculas/presentation/widgets/containers/container_dados_matricula.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';

class ContainerInfoMatricula extends StatefulWidget {
  MatriculaModalidadesModel matriculasModalidadesModel;
  ContainerInfoMatricula({super.key, required this.matriculasModalidadesModel});

  @override
  State<ContainerInfoMatricula> createState() => _ContainerInfoMatriculaState();
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
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerDadosMatricula(
                        textoTopo: 'Data da matricula',
                        textoDados: DateFormat('dd/MM/yyyy').format(
                            widget.matriculasModalidadesModel.dataMatricula!)),
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dados do aluno',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 20),
                          ContainerDadosMatricula(
                            textoTopo: 'RG',
                            textoDados: widget
                                .matriculasModalidadesModel.aluno!.rg
                                .toString(),
                          ),
                          SizedBox(width: 20),
                          ContainerDadosMatricula(
                              textoTopo: 'CPF',
                              textoDados: widget
                                  .matriculasModalidadesModel.aluno!.cpf
                                  .toString()),

                          SizedBox(width: 20),
                          ContainerDadosMatricula(
                              textoTopo: 'Data de nascimento',
                              textoDados: DateFormat('dd/MM/yyyy').format(widget
                                  .matriculasModalidadesModel
                                  .aluno!
                                  .nascimento!)),

                          SizedBox(width: 20),
                          ContainerDadosMatricula(
                              textoTopo: 'Endereço',
                              textoDados: widget
                                  .matriculasModalidadesModel.aluno!.endereco
                                  .toString()),
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dados do responsável',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            ContainerDadosMatricula(
                              textoTopo: 'Telefone',
                              widget: Tooltip(
                                message: 'Acessar WhatsApp',
                                child: TextButton(
                                    style: ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                            EdgeInsets.all(0))),
                                    onPressed: () {
                                      try {
                                        //formatando o numero de telefone
                                        String? telefoneFormatado = widget
                                            .matriculasModalidadesModel
                                            .aluno!
                                            .telefone
                                            ?.replaceAll(RegExp(r'\D'), '');
                                        WhatsappLauncher().whatsAppLauncher(
                                            telefoneFormatado ?? '');
                                      } catch (erro) {
                                        debugPrint(erro.toString());
                                      }
                                    },
                                    child: Text(
                                      widget.matriculasModalidadesModel.aluno!
                                          .telefone
                                          .toString(),
                                    )),
                              ),
                            ),
                            SizedBox(width: 20),
                            ContainerDadosMatricula(
                                textoTopo: 'Nome',
                                textoDados: widget
                                    .matriculasModalidadesModel.aluno!.nomeMae
                                    .toString()),
                            SizedBox(width: 20),
                            ContainerDadosMatricula(
                                textoTopo: 'RG',
                                textoDados: widget
                                    .matriculasModalidadesModel.aluno!.rg
                                    .toString()),
                            SizedBox(width: 20),
                            ContainerDadosMatricula(
                                textoTopo: 'CPF',
                                textoDados: widget
                                    .matriculasModalidadesModel.aluno!.cpfMae
                                    .toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
