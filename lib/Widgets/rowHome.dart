import 'package:flutter/material.dart';

class RowHome extends StatelessWidget {
  final String image;
  final String title;
  final String msg;
  final int done;

  const RowHome(this.image, this.title, this.msg, this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
      title: Text(title),
      subtitle: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(Icons.done_all, size: Checkbox.width),
          Text(" $msg"),
        ],
      ),
      trailing: PopupMenuButton<int>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        onSelected: (value) {},
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: 0,
            child: Text("Naipes"),
          ),
          PopupMenuItem(
            value: 1,
            child: Text("Silenciar Grupo"),
          )
        ],
      ),
    );
  }
}
