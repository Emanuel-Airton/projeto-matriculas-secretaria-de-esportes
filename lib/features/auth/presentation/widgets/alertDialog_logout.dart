import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/controller/auth_controller.dart';
import 'package:projeto_secretaria_de_esportes/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlertdialogLogout extends ConsumerStatefulWidget {
  const AlertdialogLogout({super.key});

  @override
  ConsumerState<AlertdialogLogout> createState() => _AlertdialogLogoutState();
}

class _AlertdialogLogoutState extends ConsumerState<AlertdialogLogout> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Supabase.instance.client.auth.currentUser;
    final authProvider = ref.read(authViewModelProvider.notifier);
    return AlertDialog(
      title: Text('Email logado',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Column(
              children: [Text(currentUser?.email ?? '')],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text('cancelar')),
        ElevatedButton(
            onPressed: () async {
              authProvider.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Splashscreen()));
            },
            child: Text('Sair')),
      ],
    );
  }
}
