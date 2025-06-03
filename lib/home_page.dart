import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/widgets/alertDialog_logout.dart';
import 'features/alunos/presentation/views/alunos_views.dart';
import 'features/matriculas/presentation/views/matriculas_form_view.dart';

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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: currentPageIndex == 0
                          ? Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.5)
                          : null),
                  child: ListTile(
                    leading: Icon(Icons.add,
                        color: currentPageIndex == 0
                            ? Colors.grey[800]
                            : Colors.white),
                    title: Text('Matriculas',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentPageIndex == 0
                                ? Colors.grey[800]
                                : Colors.white)),
                    onTap: () {
                      setState(() {
                        currentPageIndex = 0;
                        pageController.jumpToPage(0);
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: currentPageIndex == 1
                          ? Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.5)
                          : null),
                  child: ListTile(
                    leading: Icon(Icons.person,
                        color: currentPageIndex == 1
                            ? Colors.grey[800]
                            : Colors.white),
                    title: Text('Alunos',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentPageIndex == 1
                                ? Colors.grey[800]
                                : Colors.white)),
                    onTap: () => setState(() {
                      currentPageIndex = 1;
                      pageController.jumpToPage(1);
                    }),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: currentPageIndex == 2
                          ? Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.5)
                          : null),
                  child: ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.white),
                    title: Text('Usuário',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            //UserModel userModel = UserModel.semDados();
                            return AlertdialogLogout();
                          });
                    },
                  ),
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
