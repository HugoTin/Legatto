import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfigGroup extends StatelessWidget {
  const ConfigGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "2 membros",
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
                    children: [
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
                    children: [
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
                        style: TextStyle(color: Colors.red[700], fontSize: 20),
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
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(20, 20, 61, 1)),
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                indicatorWeight: 10,
                indicatorColor: Color.fromRGBO(151, 71, 255, 1),
                tabs: [Tab(text: "Membros"), Tab(text: "Naipes")],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
