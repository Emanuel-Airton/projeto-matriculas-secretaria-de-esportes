import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/matricula_modalidades_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_icons/simple_icons.dart';

class ContainerInfoMatricula extends StatefulWidget {
  MatriculaModalidadesModel modalidadesModel;
  ContainerInfoMatricula({super.key, required this.modalidadesModel});

  @override
  State<ContainerInfoMatricula> createState() => _ContainerInfoMatriculaState();
}

whatsAppLauncher() async {
  String telefone = '77999598633';
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
        height: MediaQuery.sizeOf(context).height * 0.48,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[300]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Text(
                          'Telefone: ${widget.modalidadesModel.aluno!.telefone.toString()}'),
                      IconButton(
                          icon: Icon(SimpleIcons.whatsapp),
                          onPressed: () async {
                            try {
                              await whatsAppLauncher();
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
                      'RG: ${widget.modalidadesModel.aluno!.rg.toString()}'),
                ),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Text(
                      'CPF: ${widget.modalidadesModel.aluno!.cpf.toString()}'),
                ),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Text(
                      'DATA DE NASCIMENTO: ${widget.modalidadesModel.aluno!.nascimento!.toIso8601String()}'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
