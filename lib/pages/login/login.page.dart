import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF233C95),
                Color(0xFF1B013D),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: const Text(
                  'LEGATTO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                  ),
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
                              prefixIcon: const Icon(Icons.abc),
                            ),
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
                              prefixIcon: const Icon(Icons.abc),
                              suffixIcon: const TextButton(
                                onPressed: null,
                                child: Icon(Icons.password)
                              )
                            ),
                            obscureText: true,
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
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Esqueci minha senha',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: null,
                            child: Text(
                              'Fazer cadastro',
                              style: TextStyle(color: Colors.white),
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
