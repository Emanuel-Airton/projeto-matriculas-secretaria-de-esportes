import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/buttom_atualizar_dados.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/custom_container_textFormField.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/custom_textFormField.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/profile_image_widget.dart';
import '../../data/models/aluno_model.dart';
import '../providers/aluno_provider.dart';
import '../providers/image_storage_provider.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class FormCadastroAluno extends ConsumerStatefulWidget {
  TextEditingController? controllerNomeAluno;
  TextEditingController? controllerTelefone;
  TextEditingController? controllercpf;
  TextEditingController? controllerRg;
  TextEditingController? controllerEscola;
  TextEditingController? controllerTurno;
  TextEditingController? controllerEndereco;
  TextEditingController? controllerNomeMae;
  TextEditingController? controllerRgMae;
  TextEditingController? controllerCpfMae;
  TextEditingController? controllerPostoSaude;
  TextEditingController? controllerRenda;
  Map<String, dynamic>? json;
  String? valorTurno;
  String? valorGenero;
  int? id;
  String? urlImagem;
  FormCadastroAluno(
      {super.key,
      this.controllerNomeAluno,
      this.controllerTelefone,
      this.controllercpf,
      this.controllerRg,
      this.controllerEscola,
      this.controllerTurno,
      this.controllerEndereco,
      this.controllerNomeMae,
      this.controllerRgMae,
      this.controllerCpfMae,
      this.controllerPostoSaude,
      this.controllerRenda,
      this.json,
      this.id,
      this.urlImagem,
      this.valorTurno,
      this.valorGenero});

  @override
  ConsumerState<FormCadastroAluno> createState() => _FormCadastroAlunoState();
}

class _FormCadastroAlunoState extends ConsumerState<FormCadastroAluno> {
  DateTime? dataNascimento;
  String dataNascimentoString = "";
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    widget.controllerTelefone = MaskedTextController(
        mask: '(00) 00000-0000', text: widget.controllerTelefone!.text);
    widget.controllercpf = MaskedTextController(
        mask: '000.000.000-00', text: widget.controllercpf!.text);
    widget.controllerCpfMae = MaskedTextController(
        mask: '000.000.000-00', text: widget.controllerCpfMae!.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.53,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImageWidget(urlImage: widget.urlImagem ?? ''),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.27,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'insira o nome do aluno';
                          }
                          return null;
                        },
                        onChanged: (p0) => widget.json?['nome'] = p0,
                        hintText: 'NOME DO ALUNO',
                        controller: widget.controllerNomeAluno),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.07,
                    child: CustomContainerTextformfield(
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        padding: EdgeInsets.only(left: 5.0),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'GÊNERO',
                        ),
                        value: widget.valorGenero,
                        items: ['masculino', 'feminino'].map(
                          (e) {
                            return DropdownMenuItem(
                                value: e, child: Text(e.toString()));
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            widget.valorGenero = value;
                            widget.json!['sexo'] = widget.valorGenero;
                          });
                        },
                      ),
                    )),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.15,
                  child: CustomContainerTextformfield(
                    child: Row(
                      children: [
                        Tooltip(
                          message: 'Selecionar a data',
                          child: IconButton(
                              onPressed: () async {
                                dataNascimento = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1910),
                                    lastDate: DateTime(2030));
                                //debugPrint(dataNascimento?.toIso8601String());
                                if (dataNascimento != null) {
                                  setState(() {
                                    final dateFormat = DateFormat('dd/MM/yyyy');
                                    dataNascimentoString =
                                        dateFormat.format(dataNascimento!);
                                    DateFormat('dd/MM/yyyy')
                                        .parse(dataNascimentoString);
                                  });
                                }
                              },
                              icon: const Icon(
                                size: 35,
                                Icons.calendar_month,
                                color: Colors.grey,
                              )),
                        ),
                        Text('DATA DE NASCIMENTO $dataNascimentoString',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'insira o RG do aluno';
                          }
                          return null;
                        },
                        hintText: 'RG DO ALUNO',
                        controller: widget.controllerRg),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        hintText: 'CPF DO ALUNO',
                        controller: widget.controllercpf),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        hintText: 'ESCOLA',
                        controller: widget.controllerEscola),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.07,
                  child: CustomContainerTextformfield(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Turno',
                      ),
                      value: widget.valorTurno,
                      items: ['matutino', 'vespetino'].map(
                        (e) {
                          return DropdownMenuItem(
                              value: e, child: Text(e.toString()));
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          widget.valorTurno = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: CustomContainerTextformfield(
                child: CustomTextformfield(
                    hintText: 'ENDEREÇO COMPLETO',
                    controller: widget.controllerEndereco),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.27,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        hintText: 'NOME DA MÃE',
                        controller: widget.controllerNomeMae),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        keyboardType: TextInputType.number,
                        hintText: 'TELEFONE',
                        controller: widget.controllerTelefone),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        hintText: 'RG DA MÃE',
                        controller: widget.controllerRgMae),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        hintText: 'CPF DA MÃE',
                        controller: widget.controllerCpfMae),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.23,
                  child: CustomContainerTextformfield(
                    child: CustomTextformfield(
                        hintText: 'POSTO DE SAÚDE DE REFERÊNCIA DA FAMÍLIA',
                        controller: widget.controllerPostoSaude),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            widget.json != null
                ? ButtomAtualizarDados(id: widget.id!, json: widget.json!)
                : Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ref.read(mapContentFileInfo.notifier).state = {};
                          },
                          child: Text('cancelar')),
                      SizedBox(width: 15),
                      ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              final urlImagemAsync =
                                  ref.watch(uploadImageStorage);
                              urlImagemAsync.when(
                                data: (data) async {
                                  debugPrint('data: ${data.toString()}');
                                  try {
                                    AlunoModel alunoModel = AlunoModel(
                                        nome: widget.controllerNomeAluno!.text,
                                        sexo: widget.valorGenero,
                                        telefone:
                                            widget.controllerTelefone!.text,
                                        nascimento: dataNascimento,
                                        rg: widget.controllerRg!.text,
                                        cpf: widget.controllercpf!.text,
                                        endereco:
                                            widget.controllerEndereco!.text,
                                        escola: widget.controllerEscola!.text,
                                        turno: widget.valorTurno,
                                        nomeMae: widget.controllerNomeMae!.text,
                                        rgMae: widget.controllerRgMae!.text,
                                        cpfMae: widget.controllerCpfMae!.text,
                                        postoSaude:
                                            widget.controllerPostoSaude!.text,
                                        fotoPerfilUrl: data);

                                    ref
                                        .read(alunoUseCaseProvider)
                                        .cadastrarAluno(alunoModel);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Center(
                                      child:
                                          Text('Aluno cadastrado com sucesso'),
                                    )));
                                    Navigator.pop(context);
                                  } catch (erro) {
                                    debugPrint('Erro: $erro');
                                  }
                                },
                                error: (error, stackTrace) => debugPrint(
                                    'Erro ao carregar imagem: $error'),
                                loading: () =>
                                    debugPrint('Carregando imagem...'),
                              );
                            }
                          },
                          child: Text('Salvar')),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
