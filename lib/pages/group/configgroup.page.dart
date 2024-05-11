// // ignore_for_file: prefer_const_constructors
// import 'package:flutter/material.dart';

// import 'package:legatto/widgets/rowMember.dart';
// import 'package:legatto/widgets/rowNaipe.dart';

// class ConfigGroup extends StatelessWidget {
//   const ConfigGroup({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       // initialIndex: 0,
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.fromLTRB(15, 20, 20, 40),
//               height: 300,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                 image: AssetImage("images/BackgroundConfig.png"),
//                 fit: BoxFit.fill,
//               )),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Align(
//                       alignment: Alignment.topRight,
//                       child: IconButton(
//                         onPressed: () => Navigator.pop(context),
//                         icon: Icon(
//                           Icons.close_rounded,
//                           size: 30,
//                           color: Colors.white,
//                         ),
//                       )),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: SizedBox.fromSize(
//                       size: Size.fromRadius(50),
//                       child: Image.asset(
//                         "images/logo-osrp.jpeg",
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Orquestra Sinfônica",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 23,
//                           )),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                           ))
//                     ],
//                   ),
//                   Text(
//                     "4 membros",
//                     style: (TextStyle(color: Colors.white, fontSize: 18)),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//                 height: 10.0,
//                 thickness: 10.0,
//                 color: Color.fromRGBO(12, 12, 36, 1)),
//             Container(
//               height: 200,
//               padding: EdgeInsets.only(right: 20),
//               // padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(20, 20, 61, 1),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   InkWell(
//                     onTap: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: const [
//                         SizedBox(
//                           width: 70,
//                           child: Icon(Icons.notifications_off_outlined,
//                               color: Colors.white, size: 30),
//                         ),
//                         Text(
//                           "Silenciar notificações",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         Spacer(),
//                         Icon(
//                           Icons.check_box_outline_blank_rounded,
//                           color: Colors.white,
//                           size: 30,
//                         )
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: Row(
//                       children: const [
//                         SizedBox(
//                           width: 70,
//                           child: Icon(
//                             Icons.image_outlined,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         Text(
//                           "Mídias",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 70,
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.red[900],
//                             size: 30,
//                           ),
//                         ),
//                         Text(
//                           "Excluir grupo",
//                           style:
//                               TextStyle(color: Colors.red[700], fontSize: 20),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//                 height: 10.0,
//                 thickness: 10.0,
//                 color: Color.fromRGBO(12, 12, 36, 1)),
//             Material(
//               color: Color.fromRGBO(20, 20, 61, 1),
//               child: TabBar(
//                 indicatorWeight: 3,
//                 indicatorColor: Color.fromRGBO(151, 71, 255, 1),
//                 indicatorPadding: EdgeInsets.fromLTRB(100, 0, 100, 13),
//                 tabs: const [
//                   Tab(text: "Membros"),
//                   Tab(text: "Naipes"),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
//                 color: Color.fromRGBO(20, 20, 61, 1),
//                 child: TabBarView(children: [
//                   ListView(
//                     scrollDirection: Axis.vertical,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           InkWell(
//                             onTap: () {},
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: const [
//                                 SizedBox(
//                                   width: 70,
//                                   child: Icon(
//                                     Icons.person_add_alt_1,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Adicionar membros",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 20),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(top: 30),
//                             child: InkWell(
//                               onTap: () {},
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: const [
//                                   Icon(
//                                     Icons.search,
//                                     color: Colors.white,
//                                     size: 27,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           RowMember('images/UsersExemplos/Lance-Stroll.jpg',
//                               "Lance Stroll", true, true),
//                           RowMember('images/UsersExemplos/Pierre-Gasly.jpg',
//                               "Pierre Gasly", true, false),
//                           RowMember('images/UsersExemplos/Fernando-Alonso.jpg',
//                               "Fernando Alonso", false, true),
//                           RowMember('images/UsersExemplos/Lando-Norris.jpg',
//                               "Lando Norris", false, false),
//                         ],
//                       ),
//                     ],
//                   ),
//                   ListView(
//                     scrollDirection: Axis.vertical,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           InkWell(
//                             onTap: () {},
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: const [
//                                 SizedBox(
//                                   width: 70,
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Adicionar naipe",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 20),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           RowNaipe(
//                               "images/NaipeViolino.png", "Violino", 1, true),
//                           SizedBox(height: 15),
//                           RowNaipe(
//                               "images/NaipeTrompete.png", "Trompete", 0, false),
//                           SizedBox(height: 15),
//                           RowNaipe(
//                               "images/NaipeClarinete.png", "Clarinete", 0, true)
//                         ],
//                       ),
//                     ],
//                   ),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//Próximo Sprint usar SliverAppBar (reescrever tudo ;-;)

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'package:legatto/widgets/rowMember.dart';
import 'package:legatto/widgets/rowNaipe.dart';

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
                // indicatorPadding: EdgeInsets.fromLTRB(100, 0, 100, 13),
                tabs: const [
                  Tab(text: "Membros"),
                  Tab(text: "Naipes"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                color: Color.fromRGBO(20, 20, 61, 1),
                child: TabBarView(children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/addmember'),
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
                          RowMember('images/UsersExemplos/Lance-Stroll.jpg',
                              "Lance Stroll", true, true),
                          RowMember('images/UsersExemplos/Pierre-Gasly.jpg',
                              "Pierre Gasly", true, false),
                          RowMember('images/UsersExemplos/Fernando-Alonso.jpg',
                              "Fernando Alonso", false, true),
                          RowMember('images/UsersExemplos/Lando-Norris.jpg',
                              "Lando Norris", false, false),
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
                          RowNaipe(
                              "images/NaipeViolino.png", "Violino", 1, true),
                          SizedBox(height: 15),
                          RowNaipe(
                              "images/NaipeTrompete.png", "Trompete", 0, false),
                          SizedBox(height: 15),
                          RowNaipe(
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
