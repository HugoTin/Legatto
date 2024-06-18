import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class AddMember extends StatefulWidget {
  final String id;
  const AddMember(this.id, {super.key});

  @override
  State<AddMember> createState() => _AddMemberState(id);
}

class _AddMemberState extends State<AddMember> {
  final String id;
  bool _isLoading = true;
  _AddMemberState(this.id);

  void _onEntry(BuildContext context) {
    //Adicionar o usuário a um grupo
    Navigator.pop(context);
  }

  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadCodeGroup();
  }

  Future<void> _loadCodeGroup() async {
    DocumentSnapshot<Map<String, dynamic>> codeGroup =
        await firestore.collection("group").doc(id).get();
    groupCode.text = codeGroup.data()!['code'];
    setState(() {
      _isLoading = false;
    });
  }

  TextEditingController groupLink =
      TextEditingController(text: "Finja que isso é um link");
  TextEditingController groupCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Convidar membros"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/HomeBackground.png"),
            fit: BoxFit.fill,
          )),
          child: Expanded(
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: 350,
                          child: Text("Insira o e-mail do convidado",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 25,
                                  color: Colors.white))),
                      TextField(
                          style: TextStyle(color: Colors.black),
                          maxLength: 8,
                          decoration: InputDecoration(
                            hintText: "Digite o e-mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.white,
                            counterText: "",
                          ),
                          keyboardType: TextInputType.emailAddress),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        width: 200,
                        height: 50,
                        child: OutlinedButton(
                          child: Text(
                            "CONVIDAR",
                            style: TextStyle(
                                height: 1, fontSize: 20, color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                width: 3.0,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () => _onEntry(context),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        width: 500,
                        height: 270,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.link,
                                  size: 45,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Link do Grupo",
                                    style: TextStyle(fontSize: 25))
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                fillColor: Colors.white,
                                counterText: "",
                              ),
                              style: TextStyle(color: Colors.black),
                              controller: groupLink,
                              enabled: false,
                            ),
                            SizedBox(height: 30),
                            TextButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: groupLink.text));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Copiado!'),
                                      backgroundColor:
                                          Color.fromRGBO(70, 29, 115, 1),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Copiar",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        width: 500,
                        height: 270,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.code,
                                  size: 45,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Código do Grupo",
                                    style: TextStyle(fontSize: 25))
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                fillColor: Colors.white,
                                counterText: "",
                              ),
                              style: TextStyle(color: Colors.black),
                              controller: groupCode,
                              enabled: false,
                            ),
                            SizedBox(height: 30),
                            TextButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: groupCode.text));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Copiado!'),
                                      backgroundColor:
                                          Color.fromRGBO(70, 29, 115, 1),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Copiar",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
