import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login>{

  bool hidePassword = false;

  final fieldEmail = TextEditingController();
  final fieldPassword = TextEditingController();

  void _changeVisibility(){ hidePassword = !hidePassword; }

  void _signIn(BuildContext context) async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: fieldEmail.text.trim(),
        password: fieldPassword.text.trim(),
      );

      // Navigator.pushReplacementNamed(context, "/home");
      GoRouter.of(context).go('/home');
    }
    on FirebaseAuthException catch (ex) {

      String? err = ex.code;

      switch(err){
        case 'invalid-credential':
          err = 'Email e/ou senha inválidos.';
          break;
        case 'internal-error':
          err = 'Erro interno. Tente novamente.';
          break;
        case 'invalid-email':
          err = 'Email inválido.';
          break;
        case 'invalid-password':
          err = 'Senha inválida.';
          break;
        case 'user-not-found':
          err = 'Email e/ou senha inválidos.';
          break;
        default:
          print(err);
          err = 'Erro ao entrar. Tente novamente.';

      }

      ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(
          content: Text(err),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BackgroundInício.png'),
                fit: BoxFit.fill
              )
            ),
          ),

          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 120),
                      height: 80,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                          image: AssetImage("images/LegattoLogo2.png"),
                          fit: BoxFit.fitHeight,
                        ))
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'E-mail',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                height: 50,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    hintText: "Digite seu email",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                  controller: fieldEmail,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              )
                            ]
                          ),
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Senha',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                                height: 50,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    hintText: "Digite sua senha",
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(() => _changeVisibility()),
                                      icon: Icon(
                                        hidePassword ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      padding: const EdgeInsets.only(right: 10),
                                    )
                                  ),
                                  controller: fieldPassword,
                                  obscureText: !hidePassword,
                                ),
                              )
                            ]
                          ),
                          TextButton(
                            onPressed: () => _signIn(context),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: Colors.white,
                                  )
                                ),
                                child: const Text(
                                  'ENTRAR',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Esqueci minha senha',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => 
                                  GoRouter.of(context).go('/register'),
                                  // Navigator.pushNamed(context, '/register'),
                                  child: const Text(
                                    'Fazer cadastro',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(
                        0, 0,
                        MediaQuery.of(context).size.width * 0.05, 20
                      ),
                      child: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ),
            ),
          )
        ]
      ),
    );
  }
}

