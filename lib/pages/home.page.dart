import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legatto/pages/login/login.page.dart';
import 'package:legatto/widgets/rowHome.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  void _logout(BuildContext context) {
    // posteriormente signout usando firebase
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        print('Auth data ${snapshot.hasData} ${snapshot.data!.displayName}');
        if(snapshot.hasData){ return const HomePage(); }
        else { return const Login(); }
      }
    );
  }
}

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
            icon: const Icon(Icons.logout),
          )
        ],
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pushNamed(context, "/newgroup"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/HomeBackground.png"),
          fit: BoxFit.fill,
        )),
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            // RowHome("Teste", "Orquestra Sinfônica", "Victor", 1),
            RowHome('images/logo-osrp.jpeg', "Orquestra Sinfônica"),
          ],
        ),
      ),
    );
  }
}