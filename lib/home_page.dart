import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/controller/auth_controller.dart';
import 'package:projeto_secretaria_de_esportes/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
                  leading: Icon(Icons.add,
                      color:
                          currentPageIndex == 0 ? Colors.black : Colors.white),
                  title: Text('Matriculas',
                      style: TextStyle(
                          color: currentPageIndex == 0
                              ? Colors.black
                              : Colors.white)),
                  onTap: () {
                    setState(() {
                      currentPageIndex = 0;
                      pageController.jumpToPage(0);
                    });
                  },
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.person,
                      color:
                          currentPageIndex == 1 ? Colors.black : Colors.white),
                  title: Text('Alunos',
                      style: TextStyle(
                          color: currentPageIndex == 1
                              ? Colors.black
                              : Colors.white)),
                  onTap: () => setState(() {
                    currentPageIndex = 1;
                    pageController.jumpToPage(1);
                  }),
                ),
                SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.account_circle, color: Colors.white),
                  title: Text('Usuário', style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    final currentUser =
                        Supabase.instance.client.auth.currentUser;
                    final authProvider =
                        ref.read(authViewModelProvider.notifier);
                    showDialog(
                        context: context,
                        builder: (context) {
                          //UserModel userModel = UserModel.semDados();
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Text('Email logado'),
                                      Text(currentUser?.email ?? '')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () async {
                                    authProvider.logout();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Splashscreen()));
                                  },
                                  child: Text('Sair'))
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [MatriculaFormView(), AlunosScreen()],
            ),
          )
        ],
      ),
    );
  }
}
