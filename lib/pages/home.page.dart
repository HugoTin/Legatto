import 'package:flutter/material.dart';
import 'package:legatto/widgets/rowHome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void _logout(BuildContext context) {
    // posteriormente signout usando firebase
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/LegattoLogo2.png',
          height: 50,
        ),
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: Icon(Icons.logout),
          )
        ],
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pushNamed(context, "/newgroup"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/HomeBackground.png"),
          fit: BoxFit.fill,
        )),
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // RowHome("Teste", "Orquestra Sinfônica", "Victor", 1),
            RowHome('images/logo-osrp.jpeg', "Orquestra Sinfônica"),
          ],
        ),
      ),
    );
  }
}
