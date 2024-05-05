import 'package:flutter/material.dart';
import 'package:legatto/widgets/popUpMenuNaipe.dart';

class RowNaipe extends StatelessWidget {
  final String image;
  final String name;
  final int participants;
  final bool isAdmin;

  const RowNaipe(this.image, this.name, this.participants, this.isAdmin,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 70,
            child: Image.asset(
              image,
              height: 50,
              width: 40,
            )),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(width: 10),
        Text(
          "(${participants.toString()})",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Spacer(
          flex: 100,
        ),
        PopUpMenuNaipe(isAdmin)
      ],
    );
  }
}
