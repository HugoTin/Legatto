import 'package:flutter/material.dart';

class HomeGroups extends StatelessWidget {
  final String image;
  final String title;
  final String msg;
  final int done;

  const HomeGroups(this.image, this.title, this.msg, this.done, {super.key});

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
    );
  }
}
