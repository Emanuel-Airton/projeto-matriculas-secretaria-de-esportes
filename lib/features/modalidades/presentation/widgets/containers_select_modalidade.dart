import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/modalidades_provider.dart';

class ContainersSelectModalidade extends ConsumerStatefulWidget {
  const ContainersSelectModalidade({super.key});

  @override
  ConsumerState<ContainersSelectModalidade> createState() =>
      _ContainersSelectModalidadeState();
}

bool isSelect = false;

class _ContainersSelectModalidadeState
    extends ConsumerState<ContainersSelectModalidade> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isSelect = !isSelect;
            });
            final id = 3; // Defina o ID correto da modalidade
            ref.read(selectedModalidadeIdProvider.notifier).state = id;
            //ao clicar no botao tenho que filtrar a lista passando o id da modalidade
          },
          child: Container(
              height: height * 0.1,
              width: width * 0.08,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: isSelect == false
                      ? Colors.white
                      : Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                  ]),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/football.png',
                    height: height * 0.05,
                  ),
                  Text(
                    'Futebol',
                    style: TextStyle(color: Colors.red[700]),
                  )
                ],
              )),
        ),
        TextButton(
          onPressed: () {},
          child: Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              width: MediaQuery.sizeOf(context).width * 0.08,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                  ]),
              child: Column(
                children: [
                  Image.asset('assets/images/basketball.png',
                      height: height * 0.05),
                  Text(
                    'Basquete',
                    style: TextStyle(color: Colors.red[700]),
                  )
                ],
              )),
        ),
        Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 0.08,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                ]),
            child: Column(
              children: [
                Image.asset('assets/images/dance.png', height: height * 0.05),
                Text(
                  'Dança',
                  style: TextStyle(color: Colors.red[700]),
                )
              ],
            )),
        Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 0.08,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                ]),
            child: Column(
              children: [
                Image.asset('assets/images/runner.png', height: height * 0.05),
                Text(
                  'Atletismo',
                  style: TextStyle(color: Colors.red[700]),
                )
              ],
            )),
        Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 0.08,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                ]),
            child: Column(
              children: [
                Image.asset('assets/images/handball.png',
                    height: height * 0.05),
                Text(
                  'Handebol',
                  style: TextStyle(color: Colors.red[700]),
                )
              ],
            )),
        Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 0.08,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                ]),
            child: Column(
              children: [
                Image.asset('assets/images/softball.png',
                    height: height * 0.05),
                Text(
                  'Queimada',
                  style: TextStyle(color: Colors.red[700]),
                )
              ],
            )),
        TextButton(
          onPressed: () {
            setState(() {
              isSelect = !isSelect;
            });
            final id = 1; // Defina o ID correto da modalidade
            ref.read(selectedModalidadeIdProvider.notifier).state = id;
            //ao clicar no botao tenho que filtrar a lista passando o id da modalidade
          },
          child: Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              width: MediaQuery.sizeOf(context).width * 0.08,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                  ]),
              child: Column(
                children: [
                  Image.asset('assets/images/volleyball.png',
                      height: height * 0.05),
                  Text(
                    'Volei',
                    style: TextStyle(color: Colors.red[700]),
                  )
                ],
              )),
        ),
        Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 0.08,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(2, 3))
                ]),
            child: Column(
              children: [
                Image.asset('assets/images/xadrez.png', height: height * 0.05),
                Text(
                  'Xadrez',
                  style: TextStyle(color: Colors.red[700]),
                )
              ],
            )),
      ],
    );
  }
}
