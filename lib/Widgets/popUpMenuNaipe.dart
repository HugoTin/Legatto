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
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("Membros do Naipe"),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text("Silenciar Naipe"),
        ),
        if (isAdmin)
          const PopupMenuItem(
            value: 3,
            child: Text("Excluir Naipe"),
          ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            null;
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
