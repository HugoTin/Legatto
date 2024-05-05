import 'package:flutter/material.dart';

class PopUpMenuGroup extends StatelessWidget {
  const PopUpMenuGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(
        Icons.settings_outlined,
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
          child: Text("Silenciar grupo"),
        ),
        const PopupMenuItem(
          textStyle: TextStyle(color: Colors.black),
          value: 2,
          child: Text("Sair do grupo"),
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
        }
      },
    );
  }
}
