import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/buttom_atualizar_dados.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/buttom_salvar_dados.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/custom_container_textFormField.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/custom_textFormField.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/profile_image_widget.dart';
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
  TextEditingController? controllerNascimento;

  Map<String, dynamic>? json;
  String? valorTurno;
  String? valorGenero;
  int? id;
  String? urlImagem;
  bool? enabled;
  bool? cadastrarNovoAluno;
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
      this.controllerNascimento,
      this.json,
      this.id,
      this.urlImagem,
      this.valorTurno,
      this.valorGenero,
      this.enabled,
      this.cadastrarNovoAluno});

  @override
  ConsumerState<FormCadastroAluno> createState() => _FormCadastroAlunoState();
}

class _FormCadastroAlunoState extends ConsumerState<FormCadastroAluno> {
  Widget? child = Text('Salvar');
  DateTime? dataNascimento;
  String dataNascimentoString = "";
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width > 600
              ? MediaQuery.of(context).size.width * 0.6
              : MediaQuery.of(context).size.width * 0.9, // Largura responsiva
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                  message: 'Adicionar foto do perfil',
                  child: ProfileImageWidget(urlImage: widget.urlImagem ?? '')),
              SizedBox(height: 15),

              // Nome, Gênero e Data de Nascimento
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o nome do aluno';
                        }
                        return null;
                      },
                      onChanged: (p0) => widget.json?['nome'] = p0,
                      hintText: 'NOME DO ALUNO',
                      enabled: widget.enabled,
                      controller: widget.controllerNomeAluno,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: CustomContainerTextformfield(
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione o gênero';
                          }
                          return null;
                        },
                        isExpanded: true,
                        padding: EdgeInsets.only(left: 5.0),
                        decoration: InputDecoration(
                          enabled: false,
                          border: InputBorder.none,
                          hintText: 'GÊNERO',
                        ),
                        value: widget.valorGenero,
                        items: ['masculino', 'feminino'].map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          );
                        }).toList(),
                        onChanged: widget.enabled == true
                            ? (String? value) {
                                setState(() {
                                  widget.valorGenero = value;
                                  widget.json?['sexo'] = widget.valorGenero;
                                });
                              }
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira a data de nascimento';
                        }
                        // Verifica se a data está no formato correto (10 caracteres incluindo as barras)
                        if (value.length != 10) {
                          return 'Data inválida';
                        }
                        try {
                          // Converte a string para DateTime mantendo as barras
                          DateFormat('dd/MM/yyyy').parseStrict(value);
                        } catch (e) {
                          return 'Data inválida';
                        }

                        return null;
                      },
                      enabled: widget.enabled,
                      controller: widget.controllerNascimento =
                          MaskedTextController(
                        mask: '00/00/0000',
                        text: widget.controllerNascimento?.text,
                      ),
                      hintText: 'DATA DE NASCIMENTO',
                      onChanged: (p0) {
                        if (p0 != null && p0.isNotEmpty && p0.length == 10) {
                          try {
                            // Converte a string para DateTime mantendo as barras
                            dataNascimento =
                                DateFormat('dd/MM/yyyy').parseStrict(p0);
                            // Converte para formato ISO 8601
                            widget.json?['nascimento'] =
                                dataNascimento?.toIso8601String();
                          } catch (e) {
                            widget.json?['nascimento'] = null;
                            debugPrint('Erro ao converter data: $e');
                          }
                        } else {
                          widget.json?['nascimento'] = null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // RG, CPF, Escola e Turno
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o RG do aluno';
                        }
                        return null;
                      },
                      onChanged: (p0) => widget.json?['rg'] = p0,
                      hintText: 'RG DO ALUNO',
                      enabled: widget.enabled,
                      maxLength: 10,
                      controller: widget.controllerRg,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: CustomTextformfield(
                      hintText: 'CPF DO ALUNO',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o CPF';
                        }
                        return null;
                      },
                      onChanged: (p0) => widget.json?['cpf'] = p0,
                      enabled: widget.enabled,
                      controller: widget.controllercpf = MaskedTextController(
                        mask: '000.000.000-00',
                        text: widget.controllercpf!.text,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira a escola';
                        }
                        return null;
                      },
                      hintText: 'ESCOLA',
                      onChanged: (p0) => widget.json?['escola'] = p0,
                      enabled: widget.enabled,
                      controller: widget.controllerEscola,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: CustomContainerTextformfield(
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione o turno';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Turno',
                        ),
                        value: widget.valorTurno,
                        items: ['matutino', 'vespetino'].map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          );
                        }).toList(),
                        onChanged: widget.enabled == true
                            ? (String? value) {
                                setState(() {
                                  widget.valorTurno = value;
                                  widget.json?['turno'] = value;
                                });
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Endereço
              CustomTextformfield(
                hintText: 'ENDEREÇO COMPLETO',
                onChanged: (p0) => widget.json?['endereço'] = p0,
                enabled: widget.enabled,
                controller: widget.controllerEndereco,
              ),
              SizedBox(height: 10),
              // Nome da Mãe, Telefone e RG da Mãe
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o nome da mãe ou responsável';
                        }
                        return null;
                      },
                      hintText: 'NOME DA MÃE OU RESPONSÁVEL',
                      onChanged: (p0) => widget.json?['nome_mae'] = p0,
                      enabled: widget.enabled,
                      controller: widget.controllerNomeMae,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: CustomTextformfield(
                      /*   validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o telefone';
                        }
                        return null;
                      },*/
                      keyboardType: TextInputType.number,
                      hintText: 'TELEFONE',
                      onChanged: (p0) => widget.json?['telefone'] = p0,
                      enabled: widget.enabled,
                      controller: widget.controllerTelefone =
                          MaskedTextController(
                        mask: '(00) 00000-0000',
                        text: widget.controllerTelefone!.text,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o RG';
                        }
                        return null;
                      },
                      hintText: 'RG DA MÃE',
                      onChanged: (p0) => widget.json?['rg_mae'] = p0,
                      enabled: widget.enabled,
                      maxLength: 10,
                      controller: widget.controllerRgMae,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),

              // CPF da Mãe e Posto de Saúde
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextformfield(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insira o CPF';
                        }
                        return null;
                      },
                      hintText: 'CPF DA MÃE',
                      onChanged: (p0) => widget.json?['cpf_mae'] = p0,
                      enabled: widget.enabled,
                      controller: widget.controllerCpfMae =
                          MaskedTextController(
                        mask: '000.000.000-00',
                        text: widget.controllerCpfMae!.text,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: CustomTextformfield(
                      hintText: 'POSTO DE SAÚDE DE REFERÊNCIA DA FAMÍLIA',
                      onChanged: (p0) {
                        widget.json?['posto_saude'] = p0;
                        debugPrint(
                            'json: ${widget.json?['posto_saude'].toString()}');
                      },
                      enabled: widget.enabled,
                      controller: widget.controllerPostoSaude,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Botões
              widget.json != null
                  ? ButtomAtualizarDados(id: widget.id!, json: widget.json!)
                  : Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ref.read(mapContentFileInfo.notifier).state = {};
                          },
                          child: Text('Cancelar'),
                        ),
                        SizedBox(width: 15),
                        ButtomSalvarDados(
                            nomeAluno: widget.controllerNomeAluno?.text ?? '',
                            valorGenero: widget.valorGenero ?? '',
                            telefone: widget.controllerTelefone!,
                            dataNascimento: dataNascimento,
                            rg: widget.controllerRg!,
                            cpf: widget.controllercpf!,
                            endereco: widget.controllerEndereco?.text ?? '',
                            escola: widget.controllerEscola?.text ?? '',
                            turno: widget.valorTurno ?? '',
                            nomeMae: widget.controllerNomeMae?.text ?? '',
                            rgMae: widget.controllerRgMae!,
                            cpfMae: widget.controllerCpfMae!,
                            postoSaude: widget.controllerPostoSaude?.text ?? '',
                            cadastrarNovoAluno: widget.cadastrarNovoAluno!,
                            formKey: _key),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
