import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/controller/auth_controller.dart';
import 'package:projeto_secretaria_de_esportes/features/auth/presentation/widgets/container_input_credentials.dart';
import 'package:projeto_secretaria_de_esportes/home_page.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.watch(authViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/adl10 white.png',
                  height: MediaQuery.sizeOf(context).height * 0.3),
              SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  borderOnForeground: false,
                  elevation: 10,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 30),
                          ContainerInputCredentials(
                            child1: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Insira o email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.grey),
                                  labelText: 'Email',
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(height: 15),
                          ContainerInputCredentials(
                            child1: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Insira a senha';
                                      }
                                      return null;
                                    },
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock,
                                            color: Colors.grey),
                                        labelText: 'Senha',
                                        border: InputBorder.none),
                                    obscureText: obscureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .login(email, password);
                              }
                            },
                            child: Text('Login'),
                          ),
                          SizedBox(height: 10),
                          authViewModel.when(
                            data: (data) {
                              if (data?.email != null) {
                                Text(
                                    'Bem-vindo, ${authViewModel.value?.email}');
                                Future.delayed(Duration(seconds: 1)).then(
                                    (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage())));
                              }
                              return SizedBox
                                  .shrink(); // Evita renderizar um widget vazio
                            },
                            error: (error, stackTrace) {
                              final errorMessage = error
                                      .toString()
                                      .contains('invalid_credentials')
                                  ? 'Credenciais inválidas. Verifique seu email e senha.'
                                  : 'Ocorreu um erro. Tente novamente.';
                              return Text(errorMessage.toString());
                            },
                            loading: () {
                              return CircularProgressIndicator();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
