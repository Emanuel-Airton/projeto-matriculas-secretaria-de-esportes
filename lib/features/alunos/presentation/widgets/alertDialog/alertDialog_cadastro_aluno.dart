import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/widgets/form_cadastro_aluno.dart';

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
  TextEditingController controllerNascimento = TextEditingController();

  String? valor;
  String? valorTurno;
  DateTime? dataNascimento;
  String dataNascimentoString = "";
  final _key = GlobalKey<FormState>();
  bool enabled = true;
  bool cadastrarNovoAluno = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text('Cadastro de Aluno'),
        content: Form(
            key: _key,
            child: FormCadastroAluno(
              controllerCpfMae: controllerCpfMae,
              controllerEndereco: controllerEndereco,
              controllerEscola: controllerEscola,
              controllerNomeAluno: controllerNomeAluno,
              controllerNomeMae: controllerNomeMae,
              controllerPostoSaude: controllerPostoSaude,
              controllerRg: controllerRg,
              controllerRgMae: controllerRgMae,
              controllerTelefone: controllerTelefone,
              controllerTurno: controllerTurno,
              controllercpf: controllercpf,
              controllerNascimento: controllerNascimento,
              enabled: enabled,
              valorGenero: valor,
              valorTurno: valorTurno,
              cadastrarNovoAluno: cadastrarNovoAluno,
            )),
        actions: [],
      ),
    );
  }
}
