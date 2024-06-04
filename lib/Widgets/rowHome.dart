import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowHome extends StatelessWidget {
  final String id;
  final String image;
  final String title;

  RowHome(this.id, this.image, this.title, {super.key});

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox.fromSize(
          size: const Size.fromRadius(25),
          child: Image.asset(image),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      // subtitle: Wrap(
      //   crossAxisAlignment: WrapCrossAlignment.center,
      //   children: [
      //     const Icon(Icons.done_all, size: Checkbox.width),
      //     Text(" $msg"),
      //   ],
      // ),

      /* Implementação do PopMenuButton no trailing (direita do tile) */
      trailing: PopupMenuButton<int>(
        icon: const Icon(
          Icons.more_vert,
          size: 30,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),

        /* Itens do PopMenuButton */
        itemBuilder: (context) => [
          // const PopupMenuItem(
          //   textStyle: TextStyle(color: Colors.black),
          //   value: 0,
          //   child: Text("Silenciar grupo"),
          // ),
          PopupMenuItem(
            textStyle: const TextStyle(color: Colors.black),
            value: 1,
            child: const Text("Excluir Grupo"),
            onTap: () => firestore.collection('group').doc(id).delete(),
          ),
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 2,
            child: Text("Adicionar membros"),
          )
        ],
        /* Ações de cada item do PopMenuButton */
        onSelected: (value) {
          switch (value) {
            case 0:
              null;
              break;
            case 1:
              null;
              break;
            case 2:
              Navigator.pushNamed(context, '/addmember');
          }
        },
      ),

      /* Elementos do Tile expandido */
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
              child: InkWell(
                onTap: () => GoRouter.of(context).go("/homegroup"),
                child: Row(
                  children: [
                    Image.asset("images/ChatIconeHome.png"),
                    const SizedBox(width: 30),
                    const Text(
                      "Chat",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
              child: InkWell(
                onTap: () => {
                  // print('goto /managnaipe$id, $title $image'),
                  GoRouter.of(context).go("/managnaipe/$id")
                },
                child: Row(
                  children: [
                    Image.asset("images/NaipesIconeHome.png"),
                    const SizedBox(width: 30),
                    const Text(
                      "Naipes do grupo",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
