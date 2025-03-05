import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/modalidades/data/models/modalidades_model.dart';

import '../providers/modalidades_provider.dart';

class RowContainersSelectModalidade extends ConsumerStatefulWidget {
  const RowContainersSelectModalidade({super.key});

  @override
  ConsumerState<RowContainersSelectModalidade> createState() =>
      _ContainersSelectModalidadeState();
}

class _ContainersSelectModalidadeState
    extends ConsumerState<RowContainersSelectModalidade> {
  Map<int, bool> map = {};
  bool isSelect = false;

  List<Map<String, dynamic>> listItens = [
    {'nome': 'Atletismo', 'id': 8, 'image': 'assets/images/runner.png'},
    {'nome': 'Futsal', 'id': 2, 'image': 'assets/images/basketball.png'},
    {'nome': 'Futebol', 'id': 3, 'image': 'assets/images/football.png'},
    {'nome': 'Handebol', 'id': 6, 'image': 'assets/images/handball.png'},
    {'nome': 'Oficina de Dança', 'id': 7, 'image': 'assets/images/dance.png'},
    {'nome': 'Queimada', 'id': 5, 'image': 'assets/images/softball.png'},
    {'nome': 'Xadrez', 'id': 4, 'image': 'assets/images/xadrez.png'},
    {'nome': 'volei', 'id': 1, 'image': 'assets/images/volleyball.png'},
  ];
  final ScrollController _scrollController = ScrollController();
  /*
  @override
  void initState() {
    // TODO: implement initState
    final listModalidades = ref.read(listModalidadeProvider);
    List<Map<String, dynamic>> listItens2 = [];
    if (listModalidades.value!.isNotEmpty) {
      // Map<String, dynamic> mapRecebeModalidades = {};
      for (int i = 0; i < listModalidades.value!.length; i++) {
        Map<String, dynamic> map = {
          'nome': listModalidades.value?[i].nome,
          'id': listModalidades.value?[i].id
        };

        listItens2.add(map);
      }
      listItens2.sort(
        (a, b) {
          String nomeA = a['nome'];
          String nomeB = b['nome'];
          return nomeA.compareTo(nomeB);
        },
      );
      debugPrint('valores: ${listItens2.toString()}');
    }

    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          // Ajusta a rolagem com base no movimento do scroll do mouse
          _scrollController.jumpTo(
            _scrollController.offset + pointerSignal.scrollDelta.dy,
          );
        }
      },
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listItens.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> mapItem = {
            'id': listItens[index]['id'],
            'nome': listItens[index]['nome']
          };
          isSelect = map[index] ?? false;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              //  height: height * 0.1,
              width: width * 0.085,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // fixedSize: Size(width * 0.08, height * 0.1),
                    backgroundColor: !isSelect
                        ? Colors.white
                        : Theme.of(context).colorScheme.inversePrimary,
                    padding: EdgeInsets.all(25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  setState(() {
                    ref.read(selectedModalidadeIdProvider.notifier).state =
                        ModalidadesModel.fromJson(mapItem);
                    map.clear();
                    if (map.isEmpty) {
                      map[index] = !isSelect;
                    }
                  });
                },
                child: Column(
                  children: [
                    Image.asset(
                      listItens[index]['image'].toString(),
                      height: height * 0.05,
                    ),
                    SizedBox(height: 15),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        listItens[index]['nome'].toString(),
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    )
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
