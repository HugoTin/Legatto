import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopUpMenuFile extends StatelessWidget {
  final bool isAdmin;
  final String filePath;
  final Function refreshCallback; // Callback para atualizar a lista de arquivos

  const PopUpMenuFile(this.isAdmin, this.filePath, this.refreshCallback,
      {super.key});

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
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 1,
            child: Text("Fixar"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 2,
            child: Text("Excluir"),
          ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            if (isAdmin) {
              _togglePinFile(context, filePath);
            }
            break;
          case 2:
            if (isAdmin) {
              _deleteFile(context, filePath);
            }
            break;
        }
      },
    );
  }

  Future<void> _togglePinFile(BuildContext context, String filePath) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('files').doc(filePath);
      final docSnapshot = await docRef.get();

      bool isPinned = docSnapshot.exists ? docSnapshot['isPinned'] : false;
      await docRef.set({
        'filePath': filePath,
        'isPinned': !isPinned,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(isPinned ? 'Arquivo desafixado' : 'Arquivo fixado')),
      );
      refreshCallback();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao fixar/desafixar o arquivo: $e')),
      );
    }
  }

  Future<void> _deleteFile(BuildContext context, String filePath) async {
    try {
      await FirebaseStorage.instance.ref(filePath).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Arquivo excluído com sucesso')),
      );
      refreshCallback();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao excluir o arquivo: $e')),
      );
    }
  }
}
