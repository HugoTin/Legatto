import 'package:flutter/material.dart';

class RowHome extends StatelessWidget {
  final String image;
  final String title;
  // final String msg;
  // final int done;

  // const RowHome(this.image, this.title, this.msg, this.done, {super.key});
//   const RowHome(this.image, this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () => Navigator.pushNamed(context, "/homegroup"),
//       textColor: Colors.white,
//       iconColor: Colors.white,
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: SizedBox.fromSize(
//           size: const Size.fromRadius(25),
//           child: Image.asset(image),
//         ),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 18),
//       ),
//       // subtitle: Wrap(
//       //   crossAxisAlignment: WrapCrossAlignment.center,
//       //   children: [
//       //     const Icon(Icons.done_all, size: Checkbox.width),
//       //     Text(" $msg"),
//       //   ],
//       // ),
//       trailing: PopupMenuButton<int>(
//         icon: const Icon(
//           Icons.more_vert,
//           size: 30,
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(15.0),
//           ),
//         ),
//         itemBuilder: (context) => const [
//           PopupMenuItem(
//             textStyle: TextStyle(color: Colors.black),
//             value: 0,
//             child: Text(
//               "Naipes",
//             ),
//           ),
//           PopupMenuItem(
//             textStyle: TextStyle(color: Colors.black),
//             value: 1,
//             child: Text("Silenciar Grupo"),
//           ),
//           PopupMenuItem(
//             textStyle: TextStyle(color: Colors.black),
//             value: 2,
//             child: Text("Adicionar membros"),
//           )
//         ],
//         onSelected: (value) {
//           switch (value) {
//             case 0:
//               Navigator.pushNamed(context, "/managnaipe");
//               break;
//             case 1:
//               null;
//               break;
//             case 2:
//               Navigator.pushNamed(context, '/addmember');
//           }
//         },
//       ),
//     );
//   }
// }

  const RowHome(this.image, this.title, {super.key});

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
        itemBuilder: (context) => const [
          PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 0,
            child: Text("Silenciar grupo"),
          ),
          PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 1,
            child: Text("Excluir Grupo"),
          ),
          PopupMenuItem(
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
              padding: EdgeInsets.fromLTRB(30, 20, 20, 10),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "/homegroup"),
                child: Row(
                  children: [
                    Image.asset("images/ChatIconeHome.png"),
                    SizedBox(width: 30),
                    Text(
                      "Chat",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 20, 10),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "/managnaipe"),
                child: Row(
                  children: [
                    Image.asset("images/NaipesIconeHome.png"),
                    SizedBox(width: 30),
                    Text(
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
