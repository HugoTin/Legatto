import 'package:flutter/material.dart';

class PopUpMenuUser extends StatelessWidget {
  final bool isAdmin;
  const PopUpMenuUser(this.isAdmin, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("Remover membro"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(_isAdmin()),
        ),
        const PopupMenuItem(
          value: 3,
          child: Text("Adicionar ao naipe"),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            null;
            break;
          case 2:
            if (isAdmin) {
            } else {}
            break;
          case 3:
            null;
            break;
        }
      },
    );
  }

  String _isAdmin() {
    if (isAdmin) {
      return "Remover admin";
    } else {
      return "Promover admin";
    }
  }
}
