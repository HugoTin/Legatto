// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/popUpMenuFile.dart';
import 'package:legatto/Widgets/popUpMenuGroup.dart';
import 'package:legatto/Widgets/posts.dart';

class HomeGroup extends StatefulWidget {
  const HomeGroup({super.key});

  @override
  _HomeGroupState createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _actionButton(BuildContext context) {
    null;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () => Navigator.pushNamed(context, "/configgroup"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(18),
                    child: Image.asset(
                      "images/logo-osrp.jpeg",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text("Orquestra Sinfônica")
              ],
            ),
          ),
          actions: [
            PopUpMenuGroup(),
          ],
          bottom: TabBar(
            indicatorColor: Color.fromRGBO(151, 71, 255, 1),
            indicatorWeight: 4,
            indicatorPadding: EdgeInsets.fromLTRB(70, 0, 70, 0),
            labelColor: Color.fromRGBO(151, 71, 255, 1),
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                text: "Chat",
              ),
              Tab(
                text: "Partituras",
              ),
            ],
          ),
        ),
        body: Expanded(
          child: Container(
            color: Color.fromRGBO(12, 12, 36, 1),
            // padding: EdgeInsets.all(20),
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("images/OpacidadeBackgroundChat.png"),
                    fit: BoxFit.fitWidth,
                  )),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Posts(
                          'images/UsersExemplos/Fernando-Alonso.jpg',
                          "Fernando Alonso",
                          "21/04",
                          "23:00",
                          "Título da postagem",
                          "Conteúdo da postagem",
                          true,
                          true),
                      SizedBox(height: 20),
                      Posts(
                          'images/UsersExemplos/Pierre-Gasly.jpg',
                          "Pierre Gasly",
                          "21/04",
                          "23:30",
                          "Apresentação no dia 22/04",
                          "Apresentação do primeiro sprint!!",
                          false,
                          false),
                      SizedBox(height: 20),
                      Posts(
                          'images/UsersExemplos/Lando-Norris.jpg',
                          "Lando Norris",
                          "21/04",
                          "23:31",
                          "Olá a todos!",
                          "É um prazer conhecê-los!!",
                          true,
                          false),
                      SizedBox(height: 20),
                      Posts(
                          'images/UsersExemplos/Lance-Stroll.jpg',
                          "Lance Stroll",
                          "21/04",
                          "23:35",
                          "Boa noite!!",
                          "Essa é minha primeira postagem",
                          false,
                          true),
                    ],
                  ),
                ),
                ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _RowPDF("Partitura", false),
                          SizedBox(
                            height: 10,
                          ),
                          _RowPDF("Partitura 2", true)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: _bottomButtons(),
      ),
    );
  }

  Widget _bottomButtons() {
    return _tabController.index == 0
        ? FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add_comment_rounded,
              color: Colors.black,
              size: 30,
            ),
          )
        : FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.note_add_rounded,
              color: Colors.black,
              size: 30,
            ),
          );
  }
}

class _RowPDF extends StatelessWidget {
  late String nameFile;
  late bool isAdmin;

  _RowPDF(this.nameFile, this.isAdmin, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Image.asset("images/PDF.png", height: 50, width: 50),
          SizedBox(width: 10),
          Text(
            nameFile,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Spacer(flex: 100),
          PopUpMenuFile(isAdmin)
        ],
      ),
    );
  }
}
