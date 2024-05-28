import 'package:flutter/material.dart';
import 'package:legatto/widgets/popUpMenuNaipe.dart';

class RowAddNaipe extends StatelessWidget {
  final String image;
  final String name;
  final bool exists;

  const RowAddNaipe(this.image, this.name, this.exists, {super.key});

  void _addNaipe(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!exists) {
      return SizedBox(
        height: 60,
        child: ListTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          leading: Image.asset(image),
          title: Text(
            name,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: IconButton(
            onPressed: () => _addNaipe(context),
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }
}
