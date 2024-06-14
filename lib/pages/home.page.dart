import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legatto/pages/login/login.page.dart';
import 'package:legatto/pages/profile/profilePage.dart';
import 'package:legatto/widgets/rowHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legatto/enum/naipes.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    } else {
      return const Login();
    }
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    GoRouter.of(context).go("/login");
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
        centerTitle: false,
      ),
      endDrawer: const NavigationDrawer(),
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('group')
              .where('membersUID', arrayContains: user)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var docs = snapshot.data!.docs;

            List<Widget> listGroups = docs
                .map(
                  (doc) => RowHome(
                      doc.id,
                      doc['groupImage'] != ''
                          ? 'images/${doc['groupImage']}'
                          : 'images/logo-osrp.jpeg',
                      doc['groupName']),
                )
                .toList();

            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/HomeBackground.png"),
                  fit: BoxFit.fill,
                )),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: listGroups,
                ));
          }),
    );
  }
}

popUpDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            padding: const EdgeInsets.all(10),
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      popUpCreateGroup(context);
                    },
                    child: const Text(
                      'Criar novo grupo',
                      style: TextStyle(color: Colors.black, fontSize: 23),
                      textAlign: TextAlign.center,
                    )),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      GoRouter.of(context).go("/newgroup");
                    },
                    child: const Text(
                      'Entrar em um grupo com código',
                      style: TextStyle(color: Colors.black, fontSize: 23),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        );
      });
}

popUpCreateGroup(context) {
  final fieldCreateGroupName = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!.uid;

  createGroup(BuildContext context) async {
    var naipes = {};

    Naipes.values.where((naipe) => naipe.name != 'Geral').forEach(
        (naipe) => naipes[naipe.name] = {'ativo': true, 'usuarios': []});

    firestore.collection('group').add({
      'groupImage': 'LegattoLogo2.png',
      'groupName': fieldCreateGroupName.text,
      'membersAdmin': [user],
      'membersUID': [user],
      'naipes': naipes
    });
  }

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 150,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: "Digite o nome do grupo",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: fieldCreateGroupName,
                        keyboardType: TextInputType.text,
                      ),
                      OutlinedButton(
                        child: Text(
                          "CRIAR",
                          style: TextStyle(
                              height: 1.3, fontSize: 23, color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(25, 8, 25, 8),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          createGroup(context);
                          Navigator.pop(context);
                        },
                      )
                    ]),
              ),
            ));
      });
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(92, 45, 151, 1),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var userData = snapshot.data!.data()!;
        return Container(
          color: const Color.fromRGBO(92, 45, 151, 1),
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(userData['profilePic']),
                  ),
                  const SizedBox(width: 18),
                  Text(
                    userData['name'].split(" ").elementAt(0),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                userData['email'],
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMenuItems(BuildContext context) {
    void logout(BuildContext context) {
      FirebaseAuth.instance.signOut();
      GoRouter.of(context).go("/login");
    }

    return Container(
      color: const Color.fromRGBO(92, 45, 151, 1),
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white, size: 30),
            title: const Text(
              'Perfil',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              GoRouter.of(context).go('/profilepage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white, size: 30),
            title: const Text(
              'Sair',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}
