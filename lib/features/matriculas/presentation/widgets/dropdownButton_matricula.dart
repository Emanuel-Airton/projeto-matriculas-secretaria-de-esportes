import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class DropdownbuttonMatricula extends ConsumerStatefulWidget {
  List projetos;
  DropdownbuttonMatricula({super.key, required this.projetos});

  @override
  ConsumerState<DropdownbuttonMatricula> createState() =>
      _DropdownbuttonMatriculaState();
}

class _DropdownbuttonMatriculaState
    extends ConsumerState<DropdownbuttonMatricula> {
  int? itemSelecionado;
  TextEditingController searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      validator: (value) {
        if (value == null) {
          return 'selecione um item';
        }
        return null;
      },
      value: itemSelecionado,
      hint: const Text('Selecione um projeto'),
      onChanged: (value) => setState(() => itemSelecionado = value),
      items: widget.projetos.map((projeto) {
        return DropdownMenuItem<int>(
          value: projeto.id,
          child: Text(projeto.nome.toString()),
        );
      }).toList(),
    );
  }
}
