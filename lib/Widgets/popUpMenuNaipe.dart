import 'package:flutter/material.dart';

class PopUpMenuNaipe extends StatelessWidget {
  final bool isAdmin;

  const PopUpMenuNaipe(this.isAdmin, {super.key});

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
        const PopupMenuItem(
          textStyle: TextStyle(color: Colors.black),
          value: 2,
          child: Text("Silenciar Naipe"),
        ),
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 3,
            child: Text("Excluir Naipe"),
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
