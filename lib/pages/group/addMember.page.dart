import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMember extends StatelessWidget {
  const AddMember({super.key});

  void _onEntry(BuildContext context) {
    //Adicionar o usuário a um grupo
    Navigator.pop(context);
  }

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
          child: Center(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 350,
                    child: Text("Insira o e-mail do convidado",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1, fontSize: 25, color: Colors.white))),
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
                          Text("Link do Grupo", style: TextStyle(fontSize: 25))
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 1000,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Text(
                          "Finja que isso é um link",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 35),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Copiar",
                            style: TextStyle(fontSize: 20),
                          ))
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
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 1000,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Text(
                          "12345678",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 35),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Copiar",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
