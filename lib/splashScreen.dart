import 'package:flutter/material.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/views/login_view.dart';
import 'package:projeto_secretaria_de_esportes/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _checkAuthStatus();
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  _checkAuthStatus() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    await Future.delayed(Duration(seconds: 3));
    if (currentUser != null) {
      debugPrint('usuario logado: ${currentUser.email}');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => mounted);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/adl10 white.png',
                height: MediaQuery.sizeOf(context).height * 0.3),
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
