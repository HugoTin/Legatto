import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopUpMenuFile extends StatelessWidget {
  final bool isAdmin;
  final String filePath;
  final VoidCallback onPinToggle;
  final VoidCallback onDelete;

  const PopUpMenuFile(
      this.isAdmin, this.filePath, this.onPinToggle, this.onDelete,
      {Key? key})
      : super(key: key);

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
              onPinToggle();
            }
            break;
          case 2:
            if (isAdmin) {
              onDelete();
            }
            break;
        }
      },
    );
  }
}
