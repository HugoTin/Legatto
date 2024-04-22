import 'package:flutter/material.dart';

class PopUpMenuFile extends StatelessWidget {
  final bool isAdmin;

  const PopUpMenuFile(this.isAdmin, {super.key});

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
          child: Text("Favoritar"),
        ),
        if (isAdmin)
          const PopupMenuItem(
            value: 2,
            child: Text("Renomear"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            value: 3,
            child: Text("Arquivar"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            value: 4,
            child: Text("Fixar"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            value: 5,
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
            if (isAdmin) null;
            break;
          case 4:
            if (isAdmin) null;
            break;
          case 5:
            if (isAdmin) null;
            break;
        }
      },
    );
  }
}
