import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'features/alunos/presentation/views/alunos_views.dart';
import 'features/matriculas/presentation/views/matriculas_form_view.dart';
import 'features/projetos/presentation/views/projetos_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.sizeOf(context).width * 0.2,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                DrawerHeader(
                    child: Text(
                  "Menu",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
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
                  leading: Icon(Icons.add_business, color: Colors.white),
                  title:
                      Text('Projetos', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    setState(() {
                      pageController.jumpToPage(1);
                    });
                  },
                ),
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
