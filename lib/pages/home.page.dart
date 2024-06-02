import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legatto/pages/login/login.page.dart';
import 'package:legatto/widgets/rowHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    // print('AUTH_HOME ${FirebaseAuth.instance.currentUser}');

    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    } else {
      return const Login(); // Login
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
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

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
          popUpCreateGroup(context);
        },
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
        .collection('group')
        .where('membersUID', arrayContains: user)
        .snapshots(),
        builder: (context, snapshot){

          var docs = snapshot.data!.docs;

          List<Widget> listGroups = docs.map((doc) => 
            RowHome(
              doc.id,
              doc['groupImage'] != '' ? 'images/${doc['groupImage']}' :'images/logo-osrp.jpeg', 
              doc['groupName']
            ),
          ).toList();

          // print('$docs $user');

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
            )
          );
        }
      ),
    );
  }
}

popUpDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => popUpCreateGroup(context),
                    child: const Text(
                      'Criar novo grupo',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/newgroup');
                    },
                    child: const Text(
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


popUpCreateGroup(context){

  final fieldCreateGroupName = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!.uid;

  createGroup(BuildContext context) async {

    firestore
    .collection('group')
    .add({
      'groupImage': 'LegattoLogo2.png',
      'groupName': fieldCreateGroupName.text,
      'membersAdmin': [ user ],
      'membersUID': [ user ],
      'naipes': {
        'Clarinete': {
          'ativo': true,
          'usuarios': []
        },
        'Violino': {
          'ativo': true,
          'usuarios': []
        },
      }
    });

  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    hintText: "Digite o nome do grupo",
                    fillColor: Colors.white,
                    filled: true,
                    // prefixIcon: const Icon(Icons.email),
                  ),
                  controller: fieldCreateGroupName,
                  keyboardType: TextInputType.text,
                ),
                TextButton(
                  onPressed: () => createGroup(context),
                  child: const Text(
                    'Entre',
                    style: TextStyle(
                      color: Colors.black
                    )
                  )
                )
              ]
            ),
          ),
        )
      );
    }
  );

}