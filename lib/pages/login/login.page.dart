import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        email: fieldEmail.text,
        password: fieldPassword.text,
      );

      Navigator.pushReplacementNamed(context, "/home");
    }
    on FirebaseAuthException catch (ex) {
      ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(
          content: Text(ex.message!),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/BackgroundInício.png'),
            fit: BoxFit.fill
          )
          // gradient: LinearGradient(
          //   colors: [
          //     Color(0xFF233C95),
          //     Color(0xFF1B013D),
          //   ],
          //   begin: FractionalOffset(0.0, 0.0),
          //   end: FractionalOffset(0.0, 1.0),
          //   stops: [0.0, 1.0],
          //   tileMode: TileMode.clamp
          // ),
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 300),
                child: 
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("images/LegattoLogo2.png"),
                    fit: BoxFit.fill,
                  ))
                ),
              ),
              SizedBox(
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'E-mail',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 50,
                          child: TextField(
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
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                          height: 50,
                          child: TextField(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
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
                        child: TextButton(
                          child: const Text(
                            'ENTRAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          onPressed: () => _signIn(context),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                            child: const Text(
                              'Fazer cadastro',
                              style: TextStyle(
                                color: Colors.white,
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
                child: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              )
            ],
          )
        )
      ),
    );
  }
}

