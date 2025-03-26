import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/views/pdfPreview.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/form_cadastro_aluno.dart';

class ContainerFormAluno extends ConsumerStatefulWidget {
  final AlunoModel alunoModel;
  const ContainerFormAluno({super.key, required this.alunoModel});

  @override
  ConsumerState<ContainerFormAluno> createState() => _ContainerFormAlunoState();
}

class _ContainerFormAlunoState extends ConsumerState<ContainerFormAluno> {
  TextEditingController controllerNomeAluno = TextEditingController();
  TextEditingController controllerTelefone = TextEditingController();
  TextEditingController controllercpf = TextEditingController();
  TextEditingController controllerRg = TextEditingController();
  TextEditingController controllerEscola = TextEditingController();
  TextEditingController controllerTurno = TextEditingController();
  TextEditingController controllerEndereco = TextEditingController();
  TextEditingController controllerNomeMae = TextEditingController();
  TextEditingController controllerRgMae = TextEditingController();
  TextEditingController controllerCpfMae = TextEditingController();
  TextEditingController controllerPostoSaude = TextEditingController();
  TextEditingController controllerNascimento = TextEditingController();

  String? valor;
  String? valorTurno;
  DateTime? dataNascimento;
  String? dataNascimentoString;
  bool enabled = false;
  bool cadastrarNovoAluno = false;
  Map<String, dynamic> json = {};
  @override
  void initState() {
    controllerNomeAluno.text = widget.alunoModel.nome;
    controllerTelefone.text = widget.alunoModel.telefone ?? '';
    controllercpf.text = widget.alunoModel.cpf ?? '';
    controllerRg.text = widget.alunoModel.rg ?? '';
    controllerEscola.text = widget.alunoModel.escola ?? '';
    controllerEndereco.text = widget.alunoModel.endereco ?? '';
    controllerCpfMae.text = widget.alunoModel.cpfMae ?? '';
    controllerPostoSaude.text = widget.alunoModel.postoSaude ?? '';
    controllerNomeMae.text = widget.alunoModel.nomeMae ?? '';
    controllerRgMae.text = widget.alunoModel.rgMae ?? '';
    valorTurno = widget.alunoModel.turno ?? '';
    final dateFormat = DateFormat('dd/MM/yyyy');

    if (widget.alunoModel.nascimento != null) {
      dataNascimentoString = dateFormat.format(widget.alunoModel.nascimento!);
    } else {
      dataNascimentoString = null;
    }
    controllerNascimento.text = dataNascimentoString ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.55,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                FormCadastroAluno(
                    controllerNomeAluno: controllerNomeAluno,
                    controllerTelefone: controllerTelefone,
                    controllerCpfMae: controllerCpfMae,
                    controllerEndereco: controllerEndereco,
                    controllerEscola: controllerEscola,
                    controllerNomeMae: controllerNomeMae,
                    controllerPostoSaude: controllerPostoSaude,
                    controllerRg: controllerRg,
                    controllerRgMae: controllerRgMae,
                    controllerTurno: controllerTurno,
                    controllercpf: controllercpf,
                    controllerNascimento: controllerNascimento,
                    json: json,
                    id: widget.alunoModel.id,
                    urlImagem: widget.alunoModel.fotoPerfilUrl,
                    valorTurno: widget.alunoModel.turno,
                    valorGenero: widget.alunoModel.sexo,
                    enabled: enabled,
                    cadastrarNovoAluno: cadastrarNovoAluno),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'Gerar PDF',
                      child: IconButton(
                          iconSize: 30,
                          color: Colors.grey,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Pdfpreview(
                                      alunoModel: widget.alunoModel);
                                });
                          },
                          icon: Icon(Icons.picture_as_pdf)),
                    ),
                    Tooltip(
                      message: 'Alterar os dados',
                      child: IconButton(
                          iconSize: 30,
                          color: Colors.grey,
                          onPressed: () {
                            setState(() {
                              enabled = !enabled;
                            });
                          },
                          icon: Icon(Icons.create)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
