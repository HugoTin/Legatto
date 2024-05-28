import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legatto/pages/login/login.page.dart';
import 'package:legatto/widgets/rowHome.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    // print('AUTH_HOME ${FirebaseAuth.instance.currentUser}');

    if (FirebaseAuth.instance.currentUser != null) {
      return const HomePage();
    } else {
      return const Login();
    }

    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   builder: (context, snapshot) {
    //     print('Auth data ${snapshot.hasData} ${snapshot.data!.displayName}');
    //     if(snapshot.hasData){ return const HomePage(); }
    //     else { return const Login(); }
    //   }
    // );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
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
        onPressed: () {
          popUpDialog(context);
        },
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

popUpDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            padding: EdgeInsets.all(10),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Criar novo grupo',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/newgroup');
                    },
                    child: Text(
                      'Entrar em um grupo com código',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        );
      });
}
