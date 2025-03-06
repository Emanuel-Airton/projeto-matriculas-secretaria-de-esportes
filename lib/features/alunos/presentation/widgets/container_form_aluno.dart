import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
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

  String? valor;
  String? valorTurno;
  DateTime? dataNascimento;
  String dataNascimentoString = "";
  bool enabled = false;
  Map<String, dynamic> json = {};
  @override
  void initState() {
    controllerNomeAluno.text = widget.alunoModel.nome ?? '';
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
    dataNascimentoString = dateFormat.format(widget.alunoModel.nascimento!);
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
                json: json,
                id: widget.alunoModel.id,
                urlImagem: widget.alunoModel.fotoPerfilUrl,
                valorTurno: widget.alunoModel.turno,
                valorGenero: widget.alunoModel.sexo),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Tooltip(
                message: 'Gerar PDF',
                child: IconButton(
                    iconSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    icon: Icon(Icons.picture_as_pdf)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
