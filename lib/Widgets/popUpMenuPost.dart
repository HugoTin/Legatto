import 'package:flutter/material.dart';

class PopUpMenuPost extends StatelessWidget {
  final bool isAdmin;

  const PopUpMenuPost(this.isAdmin, {super.key});

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
          child: Text("Editar"),
        ),
        if (isAdmin)
          const PopupMenuItem(
            value: 2,
            child: Text("Fixar"),
          ),
        const PopupMenuItem(
          value: 3,
          child: Text("Excluir"),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            null;
            break;
          case 2:
            if (isAdmin) null;
            break;
          case 3:
            null;
            break;
        }
      },
    );
  }
}
