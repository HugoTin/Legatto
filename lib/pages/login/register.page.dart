import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool hidePassword = false;
  bool hidePasswordAgain = false;

  final fieldNome = TextEditingController();
  final fieldEmail = TextEditingController();
  final fieldSenha = TextEditingController();
  final fieldConfirmarSenha = TextEditingController();

  void _changeVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void _changeVisibilityAgain() {
    setState(() {
      hidePasswordAgain = !hidePasswordAgain;
    });
  }

  Future<void> _register(BuildContext context) async {
    try {
      String err = '';
      final regExpSenha1 = RegExp(r'[a-z]');
      final regExpSenha2 = RegExp(r'[A-Z]');
      final regExpSenha3 = RegExp(r'[0-9]');

      fieldNome.text = fieldNome.text.trim();
      fieldEmail.text = fieldEmail.text.trim();
      fieldSenha.text = fieldSenha.text.trim();
      fieldConfirmarSenha.text = fieldConfirmarSenha.text.trim();

      if (fieldSenha.text != fieldConfirmarSenha.text) {
        err = 'Senha e confirmação de senha não coincidem.';
      } else if (fieldNome.text.length < 3) {
        err = 'Nome inválido.';
      } else if (!fieldEmail.text.contains('@') ||
          !fieldEmail.text
              .substring(fieldEmail.text.indexOf('@') + 1)
              .contains('.') ||
          fieldEmail.text.substring(0, fieldEmail.text.indexOf('@')).isEmpty) {
        err = 'Endereço de email inválido.';
      } else if (fieldSenha.text.length < 8) {
        err = 'Senha inválida. Deve ter ao menos 8 caracteres.';
      } else if (!regExpSenha1.hasMatch(fieldSenha.text)) {
        err = 'Senha deve conter ao menos 1 letra minúscula.';
      } else if (!regExpSenha2.hasMatch(fieldSenha.text)) {
        err = 'Senha deve conter ao menos 1 letra maiúscula.';
      } else if (!regExpSenha3.hasMatch(fieldSenha.text)) {
        err = 'Senha deve conter ao menos 1 número.';
      }

      if (err == '') {
        UserCredential createdUser =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: fieldEmail.text,
          password: fieldSenha.text,
        );

        await createdUser.user?.updateDisplayName(fieldNome.text);

        // Adiciona os dados do usuário ao Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(createdUser.user?.uid)
            .set({
          'name': fieldNome.text,
          'email': fieldEmail.text,
          'profilePic': '',
        });

        GoRouter.of(context).go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } on FirebaseAuthException catch (ex) {
      String? err = ex.code;

      switch (err) {
        case 'email-already-exists':
          err = 'Email já cadastrado.';
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
        default:
          print(err);
          err = 'Erro ao cadastrar. Tente novamente.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BackgroundInício.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.025,
                      20,
                      0,
                      0,
                    ),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'CADASTRO',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
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
                                'Nome',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              height: 50,
                              child: TextField(
                                controller: fieldNome,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "Digite seu nome",
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
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
                                controller: fieldEmail,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "Digite seu email",
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
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
                                controller: fieldSenha,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "Digite sua senha",
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () => _changeVisibility(),
                                    icon: Icon(
                                      hidePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    padding: const EdgeInsets.only(right: 10),
                                  ),
                                ),
                                obscureText: !hidePassword,
                              ),
                            ),
                          ],
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
                                controller: fieldConfirmarSenha,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "Digite a senha novamente",
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () => _changeVisibilityAgain(),
                                    icon: Icon(
                                      hidePasswordAgain
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    padding: const EdgeInsets.only(right: 10),
                                  ),
                                ),
                                obscureText: !hidePasswordAgain,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => _register(context),
                          child: Container(
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
                                  ),
                                ),
                                child: const Text(
                                  'CADASTRAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
