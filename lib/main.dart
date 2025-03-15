import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/home_page.dart';
import 'package:projeto_secretaria_de_esportes/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String apiKey = dotenv.env['API_KEY']!;
  await Supabase.initialize(
      url: 'https://tpnpgqawlipmufjiuneo.supabase.co', anonKey: apiKey);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromRGBO(206, 42, 42, 1),
          seedColor: const Color(0xFFCE2A2A),
        ),
        useMaterial3: true,
      ),
      home: Splashscreen(),
    );
  }
}
