import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/models/aluno_model.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/alunoNotifier.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/button_save_aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/image_storage_provider.dart';

class ButtomSalvarDados extends ConsumerStatefulWidget {
  final String nomeAluno;
  final String valorGenero;
  final TextEditingController? telefone; // Tornar explícito que pode ser nulo
  final DateTime? dataNascimento;
  final TextEditingController rg;
  final TextEditingController cpf;
  final String endereco;
  final String escola;
  final String turno;
  final String nomeMae;
  final TextEditingController rgMae;
  final TextEditingController cpfMae;
  final String postoSaude;
  final bool cadastrarNovoAluno;
  final GlobalKey<FormState> formKey;

  ButtomSalvarDados({
    required this.nomeAluno,
    required this.valorGenero,
    required this.telefone,
    this.dataNascimento,
    required this.rg,
    required this.cpf,
    required this.endereco,
    required this.escola,
    required this.turno,
    required this.nomeMae,
    required this.rgMae,
    required this.cpfMae,
    required this.postoSaude,
    required this.cadastrarNovoAluno,
    required this.formKey,
  });

  @override
  ConsumerState<ButtomSalvarDados> createState() => _ButtomSalvarDadosState();
}

class _ButtomSalvarDadosState extends ConsumerState<ButtomSalvarDados> {
  Widget? child = Text('Salvar');
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(buttonSaveAlunoProvider);
    return ElevatedButton(
        onPressed: state.isloading
            ? null
            : () {
                if (widget.formKey.currentState!.validate()) {
                  final urlImagemAsync = ref.watch(uploadImageStorage);
                  urlImagemAsync.when(
                      data: (data) async {
                        try {
                          if (widget.cadastrarNovoAluno) {
                            if (widget.cpfMae.text.isEmpty ||
                                widget.cpf.text.isEmpty) {
                              debugPrint('itens vazios');
                              debugPrint(
                                'itens: telefone:${widget.telefone?.text}, cpfMae:${widget.cpfMae.text}, cpf:${widget.cpf.text}, rgMae:${widget.rgMae.text}, rg:${widget.rg.text}',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('dados vazios')));

                              return null;
                            }
                            AlunoModel alunoModel = AlunoModel(
                              nome: widget.nomeAluno,
                              sexo: widget.valorGenero,
                              telefone: widget.telefone?.text,
                              nascimento: widget.dataNascimento!,
                              rg: widget.rg.text,
                              cpf: widget.cpf.text,
                              endereco: widget.endereco,
                              escola: widget.escola,
                              turno: widget.turno,
                              nomeMae: widget.nomeMae,
                              rgMae: widget.rgMae.text!,
                              cpfMae: widget.cpfMae.text,
                              postoSaude: widget.postoSaude,
                              fotoPerfilUrl: data,
                            );
                            // debugPrint( 'alunoModel: ${alunoModel.toJson().toString()}');
                            //    debugPrint(widget.cadastrarNovoAluno.toString());
                            await ref
                                .read(buttonSaveAlunoProvider.notifier)
                                .saveButton(() async {
                              /*    await ref
                                  .read(alunoUseCaseProvider)
                                  .cadastrarAluno(alunoModel);*/
                              await ref
                                  .read(alunoNotifierProvider.notifier)
                                  .cadastrarAluno(alunoModel);
                            });

                            child = Text('Cadastrado');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text('Aluno cadastrado com sucesso'),
                                ),
                              ),
                            );
                            /*  Future.delayed(Duration(seconds: 1))
                              .then((value) => Navigator.pop(context));*/
                          }
                        } catch (erro) {
                          debugPrint('Erro: $erro');
                        }
                      },
                      error: (error, stackTrace) =>
                          debugPrint('Erro ao carregar imagem: $error'),
                      loading: () =>
                          //debugPrint('Carregando imagem...'),
                          CircularProgressIndicator());
                }
              },
        child: state.isloading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  // valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Text('Salvar'));
  }
}
