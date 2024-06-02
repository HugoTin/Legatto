import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legatto/Widgets/rowNaipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagNaipe extends StatelessWidget {
  final String id;
  
  ManagNaipe(this.id, {super.key});

  final user = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => GoRouter.of(context).go('/home'),
              icon: const Icon(Icons.arrow_back)
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(20),
                child: Image.asset(
                  "images/logo-osrp.jpeg",
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text("Orquestra Sinfônica")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pushNamed(context, '/addnaipe'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
        // .doc(id)
        // .collection()
        .collection('group')
        .where(FieldPath.documentId, isEqualTo: id)
        .snapshots(),
        builder: (context, snapshot) {
          
          var doc = snapshot.data!.docs.first;

          Map<String, dynamic> naipes = doc['naipes'];
          // print('find12335 $naipes asd ${naipes.keys}');

          var listNaipes = naipes.keys.map((naipe) => (
            RowNaipe(
              'images/Naipe$naipe.png',
              naipe,
              naipes[naipe]['usuarios'].length,
              naipes[naipe]['ativo']
            )
          ))
          .toList();
          
          return Container(
            padding: const EdgeInsetsDirectional.all(15),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/HomeBackground.png"),
              fit: BoxFit.fill,
            )),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: listNaipes,
            ),
          );
        }
      )
    );
  }
}
