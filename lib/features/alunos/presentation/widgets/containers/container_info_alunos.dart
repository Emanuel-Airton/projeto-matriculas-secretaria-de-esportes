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
  @override
  Widget build(BuildContext context) {
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
              future: Future.delayed(Duration(milliseconds: 1500))
                  .then((value) => ref.watch(quantidadeAlunos.future)),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    throw UnimplementedError();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    throw UnimplementedError();
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text('Erro ao carregar dados');
                    }
                    Map<String, dynamic> map = snapshot.data ?? {};
                    // debugPrint(snapshot.data.toString());
                    return Column(
                      children: [
                        containerInfoListAlunos(
                          context,
                          'assets/images/student.png',
                          'Total de alunos  ${map['total']}',
                        ),
                        SizedBox(height: 30),
                        containerInfoListAlunos(
                          context,
                          'assets/images/masculino.png',
                          'Meninos ${map['masculino']}',
                        ),
                        SizedBox(height: 30),
                        containerInfoListAlunos(
                          context,
                          'assets/images/femenino.png',
                          'Meninas ${map['feminino']}',
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
    BuildContext context, String imageAsset, String totalAlunos) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.14,
    padding: EdgeInsets.all(5.0),
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
          title: Text(
            totalAlunos,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
/*
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

  @override
  Widget build(BuildContext context) {
    /* Future.delayed(Duration(seconds: 1)).then((value) {
      var listAlunos = ref.watch(quantidadeAlunos);
      listAlunos.when(
          data: (data) => debugPrint('dados: ${data.toString()}'),
          error: (error, stackTrace) {},
          loading: () {
            CircularProgressIndicator();
          });
    });*/
    var listAlunos = ref.watch(quantidadeAlunos);
    return  Container(
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
            listAlunos.when(
              data: (data) {
                return Column(
                  children: [
                    containerInfoListAlunos(
                      context,
                      'assets/images/student.png',
                      'Total de alunos  ${data!['total']}',
                    ),
                    SizedBox(height: 30),
                    containerInfoListAlunos(
                      context,
                      'assets/images/masculino.png',
                      'Meninos ${data['masculino']}',
                    ),
                    SizedBox(height: 30),
                    containerInfoListAlunos(
                      context,
                      'assets/images/femenino.png',
                      'Meninas ${data['feminino']}',
                    ),
                  ],
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) {
                return Text(error.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget containerInfoListAlunos(
    BuildContext context, String imageAsset, String totalAlunos) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.14,
    padding: EdgeInsets.all(5.0),
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
          title: Text(
            totalAlunos,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

*/
