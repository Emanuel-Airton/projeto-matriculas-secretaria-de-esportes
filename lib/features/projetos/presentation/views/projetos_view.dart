import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/projetos/presentation/providers/projetos_provider.dart';

class ProjetosView extends ConsumerStatefulWidget {
  const ProjetosView({super.key});

  @override
  ConsumerState<ProjetosView> createState() => _ProjetosViewState();
}

class _ProjetosViewState extends ConsumerState<ProjetosView> {
  @override
  Widget build(BuildContext context) {
    final asyncProjetos = ref.read(listProjetosProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Projetos'),
      ),
      body: asyncProjetos.when(
          data: (projetos) {
            return ListView.builder(
              itemCount: projetos.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, offset: Offset(2, 3)),
                          ]),
                      child: ListTile(
                        title: Text(projetos[index].nome!),
                      ),
                    ));
              },
            );
          },
          error: (error, stackTrace) => Center(
                child: Text('Erro ao carregar: ${error.toString()}'),
              ),
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }
}
