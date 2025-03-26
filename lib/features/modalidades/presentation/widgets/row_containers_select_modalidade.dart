import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/presentation/providers/matricula_modalidade_notifier.dart';
import '../providers/modalidades_provider.dart';

class RowContainersSelectModalidade extends ConsumerWidget {
  const RowContainersSelectModalidade({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listItens = [
      {
        'nome': 'Todas modalidades',
        'id': 9,
        'image': 'assets/images/adl10.png'
      },
      {'nome': 'Atletismo', 'id': 8, 'image': 'assets/images/runner.png'},
      {'nome': 'Futsal', 'id': 2, 'image': 'assets/images/football.png'},
      {'nome': 'Futebol', 'id': 3, 'image': 'assets/images/football.png'},
      {'nome': 'Handebol', 'id': 6, 'image': 'assets/images/handball.png'},
      {'nome': 'Oficina de Dança', 'id': 7, 'image': 'assets/images/dance.png'},
      {'nome': 'Queimada', 'id': 5, 'image': 'assets/images/softball.png'},
      {'nome': 'Xadrez', 'id': 4, 'image': 'assets/images/xadrez.png'},
      {'nome': 'volei', 'id': 1, 'image': 'assets/images/volleyball.png'},
    ];

    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15, // Altura responsiva
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listItens.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = listItens[index];
          var isSelected =
              ref.watch(selectedModalidadeIdProvider)?.id == item['id'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1, // Mantém a proporção quadrada
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Colors.white,
                  padding: const EdgeInsets.all(10), // Padding reduzido
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (item['id'] == 9) {
                    ref
                        .read(matriculaModalidade.notifier)
                        .buscarMatriculasModalidade();
                    ref.read(selectedModalidadeIdProvider.notifier).state =
                        null;
                  } else {
                    ref.read(matriculaModalidadeProvider.notifier).state =
                        item['id'];
                    ref
                        .read(matriculaModalidade.notifier)
                        .buscarMatriculasModalidadeFiltro(item['id']);
                    ref.read(selectedModalidadeIdProvider.notifier).state =
                        ModalidadesModel.fromJson(item);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['image'].toString(),
                      height: isSmallScreen
                          ? MediaQuery.of(context).size.height *
                              0.04 // Altura menor para telas pequenas
                          : MediaQuery.of(context).size.height *
                              0.05, // Altura padrão
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item['nome'].toString(),
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: isSmallScreen
                              ? MediaQuery.of(context).size.width *
                                  0.02 // Fonte maior para telas pequenas
                              : MediaQuery.of(context).size.width *
                                  0.01, // Fonte padrão
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
