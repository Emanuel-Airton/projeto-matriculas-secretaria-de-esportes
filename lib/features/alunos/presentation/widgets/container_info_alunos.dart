import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';

class ContainerInfoAlunos extends ConsumerStatefulWidget {
  const ContainerInfoAlunos({super.key});

  @override
  ConsumerState<ContainerInfoAlunos> createState() =>
      _ContainerInfoAlunosState();
}

class _ContainerInfoAlunosState extends ConsumerState<ContainerInfoAlunos> {
  // Map<String, dynamic>? map = {};
  @override
  void initState() {
    // TODO: implement initState
    //future();
    super.initState();
  }
/*
  future() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      var listAlunos = ref.watch(quantidadeAlunos.future);
      listAlunos.then((value) => map = value);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      var listAlunos = ref.watch(quantidadeAlunos);
      listAlunos.when(
          data: (data) => debugPrint('dados: ${data.toString()}'),
          error: (error, stackTrace) {},
          loading: () {});
    });

    return Container(
      width: MediaQuery.sizeOf(context).width * 0.14,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/adl10.png',
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            SizedBox(height: 60),
            FutureBuilder(
              future: Future.delayed(Duration(seconds: 2))
                  .then((value) => ref.watch(quantidadeAlunos.future)),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    throw UnimplementedError();
                  case ConnectionState.waiting:
                    // TODO: Handle this case.
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    throw UnimplementedError();
                  case ConnectionState.done:
                    // TODO: Handle this case.
                    if (snapshot.hasError) {
                      return Text('erro');
                    }
                    Map<String, dynamic> map = snapshot.data ?? {};
                    debugPrint(snapshot.data.toString());
                    return Column(
                      children: [
                        containerInfoListAlunos(
                          context,
                          'assets/images/student.png',
                          'Total de alunos  ${map?['total']}',
                        ),
                        SizedBox(height: 30),
                        containerInfoListAlunos(
                          context,
                          'assets/images/masculino.png',
                          'Total de meninos ${map?['masculino']}',
                        ),
                        SizedBox(height: 30),
                        containerInfoListAlunos(
                          context,
                          'assets/images/femenino.png',
                          'Total de meninas ${map?['feminino']}',
                        ),
                      ],
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget containerInfoListAlunos(
    BuildContext context, String imageAsset, String totalMeninas) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.14,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        ListTile(
          leading: Image.asset(
            imageAsset,
            height: MediaQuery.sizeOf(context).height * 0.025,
          ),
          title: Text(totalMeninas),
        ),
      ],
    ),
  );
}
