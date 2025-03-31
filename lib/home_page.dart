import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/controller/auth_controller.dart';
import 'package:projeto_secretaria_de_esportes/splashScreen.dart';
import 'features/alunos/presentation/views/alunos_views.dart';
import 'features/matriculas/presentation/views/matriculas_form_view.dart';
import 'features/projetos/presentation/views/projetos_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late PageController pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final authViewModel = ref.watch(authViewModelProvider);
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.sizeOf(context).width * 0.15,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.add, color: Colors.white),
                  title:
                      Text('Matriculas', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    setState(() {
                      pageController.jumpToPage(2);
                    });
                  },
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text('Alunos', style: TextStyle(color: Colors.white)),
                  onTap: () => setState(() {
                    pageController.jumpToPage(0);
                  }),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: IconButton(
                      onPressed: () async {
                        await ref.read(authViewModelProvider.notifier).logout();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Splashscreen()));
                      },
                      icon: Icon(Icons.account_circle, color: Colors.white)),
                  title: Text('Perfil', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [AlunosScreen(), ProjetosView(), MatriculaFormView()],
            ),
          )
        ],
      ),
    );
  }
}
