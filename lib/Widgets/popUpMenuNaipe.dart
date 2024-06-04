import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopUpMenuNaipe extends StatelessWidget {
  final String id;
  final bool isAdmin;
  final String naipe;

  PopUpMenuNaipe(this.id, this.isAdmin, this.naipe, {super.key});

  final user = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          textStyle: TextStyle(color: Colors.black),
          value: 1,
          child: Text("Membros do Naipe"),
        ),
        // const PopupMenuItem(
        //   textStyle: TextStyle(color: Colors.black),
        //   value: 2,
        //   child: Text("Silenciar Naipe"),
        // ),
        if (isAdmin)
          PopupMenuItem(
            textStyle: const TextStyle(color: Colors.black),
            value: 3,
            child: const Text("Desativar Naipe"),
            onTap: () => firestore.collection('group').doc(id).update({ 'naipes.$naipe.ativo': false }),
          ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            Navigator.pushNamed(context, "/usersnaipe");
            break;
          case 2:
            null;
            break;
          case 3:
            if (isAdmin) null;
            break;
        }
      },
    );
  }
}
