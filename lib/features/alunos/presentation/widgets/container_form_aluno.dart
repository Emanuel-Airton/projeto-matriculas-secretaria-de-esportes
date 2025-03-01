import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/image_storage_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/alertDialog_delete_aluno.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/profile_image_widget.dart';

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
  AlunoModel alunoModel = AlunoModel.semDados();
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
    return Form(
        child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: 'Alterar dados do aluno',
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          enabled = !enabled;
                        });
                      },
                      icon: Icon(Icons.create)),
                ),
                Tooltip(
                  message: 'Deletar aluno',
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertdialogDeleteAluno(
                                alunoId: widget.alunoModel.id!,
                                alunoNome: widget.alunoModel.nome));
                      },
                      icon: Icon(Icons.delete)),
                )
              ],
            ),
            ProfileImageWidget(urlImage: widget.alunoModel.fotoPerfilUrl ?? ''),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: TextField(
                      onChanged: (value) {
                        json['nome'] = value;
                        debugPrint(json.toString());
                      },
                      enabled: enabled,
                      decoration: InputDecoration(
                          hintText: 'NOME DO ALUNO',
                          border: OutlineInputBorder()),
                      controller: controllerNomeAluno),
                ),
                SizedBox(width: 15),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.12,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            hintText: 'GÊNERO DO ALUNO',
                            border: OutlineInputBorder()),
                        value: valor,
                        items: ['masculino', 'feminino']
                            .map(
                              (e) => DropdownMenuItem(
                                  value: e, child: Text(e.toString())),
                            )
                            .toList(),
                        onChanged: enabled
                            ? (value) {
                                setState(() {
                                  valor = value as String;
                                  json['genero'] = valor;
                                  debugPrint(json.toString());
                                });
                              }
                            : null)),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: TextField(
                      onChanged: (value) {
                        json['telefone'] = value;
                        debugPrint(json.toString());
                      },
                      enabled: enabled,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'TELEFONE', border: OutlineInputBorder()),
                      controller: controllerTelefone),
                ),
                SizedBox(width: 15),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: Container(
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: ListTile(
                        leading: Tooltip(
                          message: 'Selecionar a data',
                          child: IconButton(
                              onPressed: enabled
                                  ? () async {
                                      dataNascimento = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1910),
                                          lastDate: DateTime(2030));
                                      //debugPrint(dataNascimento?.toIso8601String());
                                      if (dataNascimento != null) {
                                        setState(() {
                                          final dateFormat =
                                              DateFormat('yyyy-MM-dd');
                                          dataNascimentoString = dateFormat
                                              .format(dataNascimento!);
                                          DateFormat('dd/MM/yyyy')
                                              .parse(dataNascimentoString);
                                          json['nascimento'] = dataNascimento;
                                        });
                                      }
                                    }
                                  : null,
                              icon: const Icon(
                                size: 30,
                                Icons.calendar_month,
                                color: Colors.grey,
                              )),
                        ),
                        title:
                            Text('DATA DE NASCIMENTO: $dataNascimentoString'),
                      ),
                    )),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: TextField(
                      onChanged: (value) => json['rg'] = value,
                      enabled: enabled,
                      decoration: InputDecoration(
                          hintText: 'RG DO ALUNO',
                          border: OutlineInputBorder()),
                      controller: controllerRg),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: TextField(
                      onChanged: (value) => json['cpf'] = value,
                      enabled: enabled,
                      decoration: InputDecoration(
                          hintText: 'CPF DO ALUNO',
                          border: OutlineInputBorder()),
                      controller: controllercpf),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: TextField(
                      onChanged: (value) => json['escola'] = value,
                      enabled: enabled,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          hintText: 'INFORME A ESCOLA',
                          border: OutlineInputBorder()),
                      controller: controllerEscola),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: 'Turno',
                        border: OutlineInputBorder(),
                      ),
                      value: valorTurno,
                      items: ['matutino', 'vespetino']
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.toString())))
                          .toList(),
                      onChanged: enabled
                          ? (value) =>
                              setState(() => valorTurno = value as String)
                          : null),
                ),
              ],
            ),
            SizedBox(height: 15),
            TextField(
                onChanged: (value) => json['endereço'] = value,
                enabled: enabled,
                decoration: InputDecoration(
                    hintText: 'ENDEREÇO COMPLETO',
                    border: OutlineInputBorder()),
                controller: controllerEndereco),
            SizedBox(height: 15),
            TextField(
                onChanged: (value) => json['nome_mae'] = value,
                enabled: enabled,
                decoration: InputDecoration(
                    hintText: 'NOME DA MÃE', border: OutlineInputBorder()),
                controller: controllerNomeMae),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: TextField(
                      onChanged: (value) => json['rg_mae'] = value,
                      enabled: enabled,
                      decoration: InputDecoration(
                          hintText: 'RG DA MÃE', border: OutlineInputBorder()),
                      controller: controllerRgMae),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: TextField(
                      onChanged: (value) => json['cpf_mae'],
                      enabled: enabled,
                      decoration: InputDecoration(
                          hintText: 'CPF DA MÃE', border: OutlineInputBorder()),
                      controller: controllerCpfMae),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  child: TextField(
                      onChanged: (value) => json['posto_saude'] = value,
                      decoration: InputDecoration(
                          enabled: enabled,
                          hintText: 'POSTO DE SAÚDE DE REFERÊNCIA DA FAMÍLIA',
                          border: OutlineInputBorder()),
                      controller: controllerPostoSaude),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
            SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  final urlImagemAsync = ref.watch(uploadImageStorage);
                  urlImagemAsync.when(
                    data: (data) {
                      data != null ? json['foto_perfil_url'] = data : null;
                      debugPrint('data: $data');
                      if (json.isNotEmpty) {
                        try {
                          ref
                              .read(alunoUseCaseProvider)
                              .atualizarAluno(widget.alunoModel.id!, json);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(
                            child: Text('dados atualizados!'),
                          )));
                        } catch (e) {
                          debugPrint('erro: $e');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Center(
                                  child: Text('Nenhuma alteração detectada!'))),
                        );
                      }
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
                },
                child: Text('salvar alterações'))
          ],
        ),
      ),
    ));
  }
}
