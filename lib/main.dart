import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/repositories/aluno_repository.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/data/services/aluno_remote_service.dart';
import 'package:projeto_secretaria_de_esportes/features/alunos/presentation/providers/aluno_provider.dart';
import 'package:projeto_secretaria_de_esportes/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String apiKey = dotenv.env['API_KEY']!;
  await Supabase.initialize(
      url: 'https://tpnpgqawlipmufjiuneo.supabase.co', anonKey: apiKey);

  // Inicializa o window_manager
  await windowManager.ensureInitialized();

  // Configura o tamanho inicial da janela
  WindowOptions windowOptions = WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(1000, 600),
    center: true, // Centraliza a janela
    title: 'Projeto Adolescente Nota 10', // Título da janela
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show(); // Exibe a janela
    await windowManager.focus(); // Foca na janela
    await windowManager.setFullScreen(false);
    await windowManager.maximize(); // Maximiza a janela
  });

  runApp(ProviderScope(overrides: [
    alunoServices
        .overrideWithValue(AlunoRemoteService(Supabase.instance.client))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xFFCE2A2A),
          seedColor: const Color(0xFFCE2A2A),
        ),
        useMaterial3: true,
      ),
      home: Splashscreen(),
    );
  }
}
