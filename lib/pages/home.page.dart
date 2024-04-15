import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets.dart';

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
        title: Text("Legatto"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: Icon(Icons.logout),
          )
        ],
        centerTitle: true,
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
          gradient: LinearGradient(
              colors: [
                const Color(0xFF233C95),
                const Color(0xFF1B013D),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ListView(
          children: [
            HomeGroups("Teste", "Orquestra", "Victor", 1),
          ],
        ),
      ),
    );
  }
}


