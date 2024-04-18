import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Text(
                'CADASTRO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
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
                            'Nome',
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
                              hintText: "Digite seu nome",
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        )
                      ]
                    ),
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
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                              suffixIcon: const TextButton(
                                onPressed: null,
                                child: Icon(Icons.remove_red_eye)
                              )
                            ),
                            obscureText: true,
                          ),
                        )
                      ]
                    ),
                     Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Confirme sua senha',
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
                              hintText: "Digite a senha novamente",
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: const TextButton(
                                onPressed: null,
                                child: Icon(Icons.remove_red_eye)
                              )
                            ),
                            obscureText: true,
                          ),
                        )
                      ]
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 100),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
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
                            'CADASTRAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}
