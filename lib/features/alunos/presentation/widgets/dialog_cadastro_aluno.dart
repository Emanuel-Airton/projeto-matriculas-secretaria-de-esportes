import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';

class DialogCadastroAluno extends ConsumerStatefulWidget {
  const DialogCadastroAluno({super.key});

  @override
  ConsumerState<DialogCadastroAluno> createState() =>
      _DialogCadastroAlunoState();
}

class _DialogCadastroAlunoState extends ConsumerState<DialogCadastroAluno> {
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
  TextEditingController controllerRenda = TextEditingController();
  String? valor;
  String? valorTurno;
  DateTime? dataNascimento;
  String dataNascimentoString = "";
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text('Cadastro de Aluno'),
        content: Form(
            child: Container(
          width: MediaQuery.sizeOf(context).width * 0.5,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  decoration: InputDecoration(hintText: 'NOME DO ALUNO'),
                  controller: controllerNomeAluno),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'GÊNERO DO ALUNO',
                        ),
                        value: valor,
                        items: ['masculino', 'feminino'].map(
                          (e) {
                            return DropdownMenuItem(
                                value: e, child: Text(e.toString()));
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            valor = value;
                          });
                        },
                      )),
                  SizedBox(width: 30),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.1,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'TELEFONE'),
                        controller: controllerTelefone),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      child: ListTile(
                        leading: Tooltip(
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
                        title:
                            Text('DATA DE NASCIMENTO: $dataNascimentoString'),
                      )),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: TextField(
                        decoration: InputDecoration(hintText: 'RG DO ALUNO'),
                        controller: controllerRg),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: TextField(
                        decoration: InputDecoration(hintText: 'CPF DO ALUNO'),
                        controller: controllercpf),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: TextField(
                        decoration: InputDecoration(hintText: 'ESCOLA'),
                        controller: controllerEscola),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.1,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: 'Turno',
                      ),
                      value: valorTurno,
                      items: ['matutino', 'vespetino'].map(
                        (e) {
                          return DropdownMenuItem(
                              value: e, child: Text(e.toString()));
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          valorTurno = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                  decoration: InputDecoration(hintText: 'ENDEREÇO COMPLETO'),
                  controller: controllerEndereco),
              TextField(
                  decoration: InputDecoration(hintText: 'NOME DA MÃE'),
                  controller: controllerNomeMae),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: TextField(
                        decoration: InputDecoration(hintText: 'RG DA MÃE'),
                        controller: controllerRgMae),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: TextField(
                        decoration: InputDecoration(hintText: 'CPF DA MÃE'),
                        controller: controllerCpfMae),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: TextField(
                        decoration: InputDecoration(
                            hintText:
                                'POSTO DE SAÚDE DE REFERÊNCIA DA FAMÍLIA'),
                        controller: controllerPostoSaude),
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(width: 30),
            ],
          ),
        )),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancelar')),
          ElevatedButton(
              onPressed: () async {
                //  double renda = double.parse(controllerRenda.text);
                try {
                  AlunoModel alunoModel = AlunoModel(
                      nome: controllerNomeAluno.text,
                      sexo: 'm',
                      telefone: controllerTelefone.text,
                      nascimento: dataNascimento,
                      rg: controllerRg.text,
                      cpf: controllercpf.text,
                      endereco: controllerEndereco.text,
                      escola: controllerEscola.text,
                      turno: controllerTurno.text,
                      nomeMae: controllerNomeMae.text,
                      rgMae: controllerRgMae.text,
                      cpfMae: controllerCpfMae.text,
                      postoSaude: controllerPostoSaude.text,
                      renda: 1);
                  ref.read(alunoUseCaseProvider).cadastrarAluno(alunoModel);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(
                    child: Text('Aluno cadastrado com sucesso'),
                  )));
                  Navigator.pop(context);
                } catch (erro) {
                  debugPrint('Erro: $erro');
                }
              },
              child: Text('Salvar'))
        ],
      ),
    );
  }
}
