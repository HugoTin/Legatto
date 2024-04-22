// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'package:legatto/widgets/popUpMenuNaipe.dart';
import 'package:legatto/widgets/popUpMenuUser.dart';

class ConfigGroup extends StatelessWidget {
  const ConfigGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 20, 40),
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("images/BackgroundConfig.png"),
                fit: BoxFit.fill,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(50),
                      child: Image.asset(
                        "images/logo-osrp.jpeg",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Orquestra Sinfônica",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Text(
                    "4 membros",
                    style: (TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Divider(
                height: 10.0,
                thickness: 10.0,
                color: Color.fromRGBO(12, 12, 36, 1)),
            Container(
              height: 200,
              padding: EdgeInsets.only(right: 20),
              // padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(20, 20, 61, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 70,
                          child: Icon(Icons.notifications_off_outlined,
                              color: Colors.white, size: 30),
                        ),
                        Text(
                          "Silenciar notificações",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 70,
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          "Mídias",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Icon(
                            Icons.delete,
                            color: Colors.red[900],
                            size: 30,
                          ),
                        ),
                        Text(
                          "Excluir grupo",
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
                height: 10.0,
                thickness: 10.0,
                color: Color.fromRGBO(12, 12, 36, 1)),
            Material(
              color: Color.fromRGBO(20, 20, 61, 1),
              child: TabBar(
                indicatorWeight: 3,
                indicatorColor: Color.fromRGBO(151, 71, 255, 1),
                indicatorPadding: EdgeInsets.fromLTRB(100, 0, 100, 13),
                tabs: const [
                  Tab(text: "Membros"),
                  Tab(text: "Naipes"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                color: Color.fromRGBO(20, 20, 61, 1),
                child: TabBarView(children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 70,
                                  child: Icon(
                                    Icons.person_add_alt_1,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  "Adicionar membros",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _RowMember('images/UsersExemplos/Lance-Stroll.jpg',
                              "Lance Stroll", true, true),
                          SizedBox(
                            height: 15,
                          ),
                          _RowMember('images/UsersExemplos/Pierre-Gasly.jpg',
                              "Pierre Gasly", true, false),
                          SizedBox(
                            height: 15,
                          ),
                          _RowMember('images/UsersExemplos/Fernando-Alonso.jpg',
                              "Fernando Alonso", false, true),
                          SizedBox(
                            height: 15,
                          ),
                          _RowMember('images/UsersExemplos/Lando-Norris.jpg',
                              "Lando Norris", false, false),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 70,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  "Adicionar naipe",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          _RowNaipe(
                              "images/NaipeViolino.png", "Violino", 1, true),
                          SizedBox(height: 15),
                          _RowNaipe(
                              "images/NaipeTrompete.png", "Trompete", 0, false),
                          SizedBox(height: 15),
                          _RowNaipe(
                              "images/NaipeClarinete.png", "Clarinete", 0, true)
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
----- ROW MEMBER -----
Template linha do membro na aba de informações do grupo
*/
// ignore: must_be_immutable
class _RowMember extends StatelessWidget {
  late String image;
  late String name;
  late bool isAdmin;
  late bool isUser;

  _RowMember(this.image, this.name, this.isAdmin, this.isUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(25),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        if (isAdmin)
          SizedBox(
            width: 50,
            child: Text(
              "Admin",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Color.fromRGBO(191, 141, 255, 1),
                fontSize: 10,
              ),
            ),
          ),
        Spacer(
          flex: 100,
        ),
        if (isUser) PopUpMenuUser(isAdmin)
      ],
    );
  }
}

/*
----- ROW NAIPE -----
Template linha do naipe na aba de informações do grupo
*/
class _RowNaipe extends StatelessWidget {
  final String image;
  final String name;
  final int participants;
  final bool isAdmin;

  const _RowNaipe(this.image, this.name, this.participants, this.isAdmin,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 70,
            child: Image.asset(
              image,
              height: 40,
              width: 40,
            )),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(width: 10),
        Text(
          "(${participants.toString()})",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Spacer(
          flex: 100,
        ),
        PopUpMenuNaipe(isAdmin)
      ],
    );
  }
}
